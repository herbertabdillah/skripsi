package contract_test

import (
	"testing"

	"github.com/herbertabdillah/skripsi-contract-new/config"
	"github.com/herbertabdillah/skripsi-contract-new/contract"
	"github.com/herbertabdillah/skripsi-contract-new/state"
	testhelper "github.com/herbertabdillah/skripsi-contract-new/test"

	testcc "github.com/hyperledger-labs/cckit/testing"
	expectcc "github.com/hyperledger-labs/cckit/testing/expect"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

func TestCourse(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "Course")
}

var _ = Describe(`Course`, func() {
	var chaincode *testcc.MockStub
	var factory testhelper.Factory
	BeforeEach(func() {
		chaincode = testcc.NewMockStub(`contract`, contract.NewCC())
		factory = testhelper.Factory{Chaincode: chaincode}
		chaincode.Invoke("MasterData:init")
	})
	Describe(`insertCourseSemester`, func() {
		It(`insert CourseSemester data`, func() {
			courseId, _ := factory.Course("")
			lecturerId := factory.Lecturer()

			insertResponse := chaincode.Invoke("Administration:insertCourseSemester", "2", "2017", "odd", courseId, lecturerId)
			getResponse := chaincode.Query("Administration:getCourseSemester", "2")
			courseSemester := expectcc.PayloadIs(getResponse, &state.CourseSemester{}).(state.CourseSemester)

			expectcc.ResponseOk(insertResponse)
			expectcc.ResponseOk(getResponse)
			Expect(courseSemester.Id).To(Equal("2"))
			Expect(courseSemester.Year).To(Equal(2017))
			Expect(courseSemester.Semester).To(Equal("odd"))
			Expect(courseSemester.LecturerId).To(Equal(lecturerId))
			Expect(courseSemester.CourseId).To(Equal(courseId))
		})
	})

	Describe(`insertCoursePlan`, func() {
		When(`class is full`, func() {
			It(`error`, func() {
				defaultConfig := config.MAX_STUDENT_PER_CLASS
				config.MAX_STUDENT_PER_CLASS = 3

				studentId, _, departmentId := factory.Student("", "", 0, "")
				studentId2, _, _ := factory.Student("", departmentId, 0, "")
				studentId3, _, _ := factory.Student("", departmentId, 0, "")
				studentId4, _, _ := factory.Student("", departmentId, 0, "")
				chaincode.Invoke("Administration:startYear", 2017, "odd")
				courseSemesterId, _, _ := factory.CourseSemester(departmentId, "", "", 2017, "odd")

				factory.CoursePlan(departmentId, studentId, []string{courseSemesterId}, 2017, "odd")
				factory.CoursePlan(departmentId, studentId2, []string{courseSemesterId}, 2017, "odd")
				factory.CoursePlan(departmentId, studentId3, []string{courseSemesterId}, 2017, "odd")

				insertResponse := chaincode.Invoke("Course:insertCoursePlan", "1", "2017", "odd", studentId4, "approved", `["`+courseSemesterId+`"]`)

				expectcc.ResponseError(insertResponse)

				config.MAX_STUDENT_PER_CLASS = defaultConfig
			})
		})
		It(`insert CoursePlan data`, func() {
			studentId, _, departmentId := factory.Student("", "", 0, "")
			chaincode.Invoke("Administration:startYear", 2017, "odd")
			courseSemesterId, _, _ := factory.CourseSemester(departmentId, "", "", 2017, "odd")
			courseSemesterId2, _, _ := factory.CourseSemester(departmentId, "", "", 2017, "odd")

			insertResponse := chaincode.Invoke("Course:insertCoursePlan", "1", "2017", "odd", studentId, "approved", `["`+courseSemesterId+`","`+courseSemesterId2+`"]`)
			getResponse := chaincode.Query("Course:getCoursePlan", "1")
			coursePlan := expectcc.PayloadIs(getResponse, &state.CoursePlan{}).(state.CoursePlan)

			expectcc.ResponseOk(insertResponse)
			expectcc.ResponseOk(getResponse)
			Expect(coursePlan.Id).To(Equal("1"))
			Expect(coursePlan.Status).To(Equal("approved"))
			Expect(coursePlan.CourseSemesterIds).To(Equal([]string{courseSemesterId, courseSemesterId2}))
		})

		It(`insert CourseResult data`, func() {
			studentId, _, departmentId := factory.Student("", "", 0, "")
			chaincode.Invoke("Administration:startYear", 2017, "odd")
			courseSemesterId, courseId, _ := factory.CourseSemester(departmentId, "", "", 2017, "odd")
			courseSemesterId2, courseId2, _ := factory.CourseSemester(departmentId, "", "", 2017, "odd")

			insertResponse := chaincode.Invoke("Course:insertCoursePlan", "1", "2017", "odd", studentId, "approved", `["`+courseSemesterId+`","`+courseSemesterId2+`"]`)
			getResponse := chaincode.Query("Course:getCourseResult", "1")
			courseResult := expectcc.PayloadIs(getResponse, &state.CourseResult{}).(state.CourseResult)

			expectcc.ResponseOk(insertResponse)
			expectcc.ResponseOk(getResponse)
			Expect(courseResult.Id).To(Equal("1"))
			Expect(courseResult.Year).To(Equal(2017))
			Expect(courseResult.Semester).To(Equal("odd"))
			Expect(courseResult.Result).To(Equal([]state.CourseSemeterResult{
				{CourseSemesterId: courseSemesterId, Score: 0, Pass: false, CourseId: courseId},
				{CourseSemesterId: courseSemesterId2, Score: 0, Pass: false, CourseId: courseId2},
			}))
		})
	})

	Describe(`updateCourseResult`, func() {
		It(`update CourseResult data`, func() {
			studentId, _, departmentId := factory.Student("", "", 0, "")
			chaincode.Invoke("Administration:startYear", 2017, "odd")

			courseSemesterId, courseId, _ := factory.CourseSemester(departmentId, "", "", 2017, "odd")
			courseSemesterId2, courseId2, _ := factory.CourseSemester(departmentId, "", "", 2017, "odd")
			coursePlanId, _, _ := factory.CoursePlan(departmentId, studentId, []string{courseSemesterId, courseSemesterId2}, 2017, "odd")

			insertResponse := chaincode.Invoke("Course:updateCourseResult", courseSemesterId, coursePlanId, "3")
			getResponse := chaincode.Query("Course:getCourseResult", coursePlanId)
			courseResult := expectcc.PayloadIs(getResponse, &state.CourseResult{}).(state.CourseResult)

			expectcc.ResponseOk(insertResponse)
			expectcc.ResponseOk(getResponse)
			Expect(courseResult.Id).To(Equal(coursePlanId))
			Expect(courseResult.Year).To(Equal(2017))
			Expect(courseResult.Semester).To(Equal("odd"))
			Expect(courseResult.Result).To(Equal([]state.CourseSemeterResult{
				{CourseSemesterId: courseSemesterId, Score: 3, Pass: true, CourseId: courseId},
				{CourseSemesterId: courseSemesterId2, Score: 0, Pass: false, CourseId: courseId2},
			}))
		})
	})
})
