package contract_test

import (
	"testing"

	"github.com/herbertabdillah/skripsi-contract-new/config"
	"github.com/herbertabdillah/skripsi-contract-new/contract"
	"github.com/herbertabdillah/skripsi-contract-new/state"
	testcc "github.com/hyperledger-labs/cckit/testing"
	expectcc "github.com/hyperledger-labs/cckit/testing/expect"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

func TestLifecycleEndToEnd(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "Main suite")
}

var _ = Describe(`Lifecycle End to End (from master data to graduation)`, func() {
	var chaincode *testcc.MockStub

	It("run as expected", func() {
		chaincode = testcc.NewMockStub(`contract`, contract.NewCC())

		config.MAX_STUDENT_PER_CLASS = 3
		expectcc.ResponseOk(chaincode.Init())

		masterData(chaincode)
		userLecturer(chaincode)

		expectcc.ResponseOk(chaincode.Invoke("User:insertStudent", "2", "Soekarno", "11100910000047", "1", 2010, "active", "2"))
		expectcc.ResponseOk(chaincode.Invoke("Administration:startYear", 2010, "odd"))
		expectcc.ResponseOk(chaincode.Invoke("Administration:endYear", 2010, "odd"))

		userStudent(chaincode)
		startYear2017(chaincode)
		courseSemester(chaincode)
		coursePlan(chaincode)
		updateCourseResult(chaincode)

		// haven't done all course
		expectcc.ResponseError(chaincode.Invoke("Graduation:graduate", "1"))

		endYear2017AndCheckDroupout(chaincode)

		expectcc.ResponseOk(chaincode.Invoke("Administration:startYear", 2018, "even"))

		student1RetakeCourse(chaincode)
		graduateStudent1(chaincode)

		config.MAX_STUDENT_PER_CLASS = 40
	})
})

func masterData(chaincode *testcc.MockStub) {
	chaincode.Invoke("MasterData:init")
	chaincode.Invoke("MasterData:insertFaculty", "1", "Sains dan Teknologi")
	chaincode.Invoke("MasterData:insertDepartment", "1", "Teknik Informatika", "1")
	chaincode.Invoke("MasterData:insertCourse", "1", "1", "Dasar dasar pemrograman", 6, "class")
	chaincode.Invoke("MasterData:insertCourse", "2", "1", "Matematika dasar", 3, "class")
	chaincode.Invoke("MasterData:insertCourse", "3", "1", "Matematika diskrit", 3, "class")
}

func userLecturer(chaincode *testcc.MockStub) {
	chaincode.Invoke("User:insertLecturer", "1", "Donald Knuth", "19450001")
	chaincode.Invoke("User:insertLecturer", "2", "Ken Thompson", "19450002")
	chaincode.Invoke("User:insertLecturer", "3", "Thomas Cormen", "19450003")
}

func userStudent(chaincode *testcc.MockStub) {
	chaincode.Invoke("User:insertStudent", "1", "Herbert", "11170910000046", "1", 2017, "active", "2")
	chaincode.Invoke("User:insertStudent", "3", "Natsir", "11170910000048", "1", 2017, "active", "2")
	chaincode.Invoke("User:insertStudent", "4", "Muso", "11170910000049", "1", 2017, "active", "2")
	chaincode.Invoke("User:insertStudent", "5", "Cokro", "11170910000050", "1", 2017, "active", "2")
	chaincode.Invoke("User:insertStudent", "6", "Aidit", "11170910000051", "1", 2017, "active", "2")
	chaincode.Invoke("User:insertStudent", "7", "Kahar", "11170910000052", "1", 2017, "active", "2")
}

func startYear2017(chaincode *testcc.MockStub) {
	chaincode.Invoke("Administration:startYear", 2017, "even")
	chaincode.Invoke("Administration:endYear", 2017, "even")
	chaincode.Invoke("Administration:startYear", 2017, "odd")
}

func courseSemester(chaincode *testcc.MockStub) {
	chaincode.Invoke("Administration:insertCourseSemester", "1", "2017", "odd", "1", "1")
	chaincode.Invoke("Administration:insertCourseSemester", "2", "2017", "odd", "2", "2")
	chaincode.Invoke("Administration:insertCourseSemester", "3", "2017", "odd", "3", "3")
}

func coursePlan(chaincode *testcc.MockStub) {
	chaincode.Invoke("Course:insertCoursePlan", "1", "2017", "odd", "1", "approved", `["1","2","3"]`)
	chaincode.Invoke("Course:insertCoursePlan", "1002", "2017", "odd", "5", "approved", `["1"]`)
	chaincode.Invoke("Course:insertCoursePlan", "1003", "2017", "odd", "6", "approved", `["1"]`)
}

func updateCourseResult(chaincode *testcc.MockStub) {
	chaincode.Invoke("Course:updateCourseResult", "1", "1", "1")
	chaincode.Invoke("Course:updateCourseResult", "2", "1", "3.4")
	chaincode.Invoke("Course:updateCourseResult", "3", "1", "4")
}

func endYear2017AndCheckDroupout(chaincode *testcc.MockStub) {
	expectcc.ResponseOk(chaincode.Invoke("Administration:endYear", 2017, "odd"))

	queryResponse := chaincode.Query("User:getStudent", "2")
	student := expectcc.PayloadIs(queryResponse, &state.Student{}).(state.Student)
	Expect(student.Status).To(Equal("drop_out"))
	Expect(student.ExitYear).To(Equal(2017))
}

func student1RetakeCourse(chaincode *testcc.MockStub) {
	expectcc.ResponseOk(chaincode.Invoke("Administration:insertCourseSemester", "4", "2018", "even", "1", "1"))
	expectcc.ResponseOk(chaincode.Invoke("Course:insertCoursePlan", "2", "2018", "even", "1", "approved", `["4"]`))
	expectcc.ResponseOk(chaincode.Invoke("Course:updateCourseResult", "4", "2", "4"))
}

func graduateStudent1(chaincode *testcc.MockStub) {
	queryResponse := chaincode.Query("Graduation:getTranscript", "1")
	transcript := expectcc.PayloadIs(queryResponse, &state.Transcript{}).(state.Transcript)
	Expect(transcript.Score).To(Equal(3.85))
	Expect(transcript.TranscriptResult).To(Equal([]state.TranscriptResult{
		{CourseResultId: "2", CourseId: "1", Year: 2018, Semester: "even", Score: 4, Pass: true},
		{CourseResultId: "1", CourseId: "2", Year: 2017, Semester: "odd", Score: 3.4, Pass: true},
		{CourseResultId: "1", CourseId: "3", Year: 2017, Semester: "odd", Score: 4, Pass: true},
	}))

	expectcc.ResponseOk(chaincode.Invoke("Graduation:graduate", "1"))

	queryResponse = chaincode.Query("User:getStudent", "1")
	student := expectcc.PayloadIs(queryResponse, &state.Student{}).(state.Student)
	Expect(student.Status).To(Equal("graduated"))
	Expect(student.ExitYear).To(Equal(2018))
}
