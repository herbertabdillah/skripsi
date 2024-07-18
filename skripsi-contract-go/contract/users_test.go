package contract_test

import (
	"testing"

	"github.com/herbertabdillah/skripsi-contract-new/contract"
	"github.com/herbertabdillah/skripsi-contract-new/state"
	testhelper "github.com/herbertabdillah/skripsi-contract-new/test"
	testcc "github.com/hyperledger-labs/cckit/testing"
	expectcc "github.com/hyperledger-labs/cckit/testing/expect"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

func TestUsers(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "User")
}

var _ = Describe(`User`, func() {
	var chaincode *testcc.MockStub
	var factory testhelper.Factory
	BeforeEach(func() {
		chaincode = testcc.NewMockStub(`contract`, contract.NewCC())
		factory = testhelper.Factory{Chaincode: chaincode}
		chaincode.Invoke("MasterData:init")
	})

	Describe(`insertLecturer`, func() {
		It(`insert faculty data`, func() {
			insertResponse := chaincode.Invoke("User:insertLecturer", "2", "Ken Thompson", "19450002")
			getResponse := chaincode.Query("User:getLecturer", "2")
			lecturer := expectcc.PayloadIs(getResponse, &state.Lecturer{}).(state.Lecturer)

			expectcc.ResponseOk(insertResponse)
			expectcc.ResponseOk(getResponse)
			Expect(lecturer.Name).To(Equal("Ken Thompson"))
			Expect(lecturer.Nik).To(Equal("19450002"))
		})
	})

	Describe(`insertStudent`, func() {
		It(`insert student data`, func() {
			departmentId, _ := factory.Depertment("")
			lecturerId := factory.Lecturer()

			insertResponse := chaincode.Invoke("User:insertStudent", "2", "Soekarno", "11100910000047", departmentId, 2010, "active", lecturerId)
			getResponse := chaincode.Query("User:getStudent", "2")
			student := expectcc.PayloadIs(getResponse, &state.Student{}).(state.Student)

			expectcc.ResponseOk(insertResponse)
			expectcc.ResponseOk(getResponse)

			Expect(student.Name).To(Equal("Soekarno"))
			Expect(student.Nim).To(Equal("11100910000047"))
			Expect(student.EntryYear).To(Equal(2010))
			Expect(student.Status).To(Equal("active"))
			Expect(student.DepartmentId).To(Equal(departmentId))
			Expect(student.SupervisorLecturerId).To(Equal(lecturerId))
		})

		It(`insert transcript data`, func() {
			departmentId, _ := factory.Depertment("")
			lecturerId := factory.Lecturer()

			insertResponse := chaincode.Invoke("User:insertStudent", "2", "Soekarno", "11100910000047", departmentId, 2010, "active", lecturerId)
			getResponse := chaincode.Query("Graduation:getTranscript", "2")
			transcript := expectcc.PayloadIs(getResponse, &state.Transcript{}).(state.Transcript)

			expectcc.ResponseOk(insertResponse)
			expectcc.ResponseOk(getResponse)
			Expect(transcript.Id).To(Equal("2"))
			Expect(transcript.Score).To(Equal(0.0))
			Expect(transcript.StudentId).To(Equal("2"))
			Expect(transcript.TranscriptResult).To(Equal([]state.TranscriptResult{}))
		})
	})
})
