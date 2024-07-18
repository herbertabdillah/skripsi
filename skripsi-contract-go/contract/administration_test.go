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

func TestAdministration(t *testing.T) {
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

	Describe(`StartYear`, func() {
		It(`insert CourseYear data and update ApplicationConfig`, func() {
			insertResponse := chaincode.Invoke("Administration:startYear", 2010, "odd")
			getResponse := chaincode.Query("Administration:getCurrentCourseYear")
			courseYear := expectcc.PayloadIs(getResponse, &state.CourseYear{}).(state.CourseYear)

			expectcc.ResponseOk(insertResponse)
			expectcc.ResponseOk(getResponse)
			Expect(courseYear.Year).To(Equal(2010))
			Expect(courseYear.Semester).To(Equal("odd"))
			Expect(courseYear.Status).To(Equal("start"))
		})
	})

	Describe(`EndYear`, func() {
		It(`insert CourseYear data and update ApplicationConfig`, func() {
			chaincode.Invoke("Administration:startYear", 2010, "odd")
			insertResponse := chaincode.Invoke("Administration:endYear", 2010, "odd")
			getResponse := chaincode.Query("Administration:getCurrentCourseYear")
			courseYear := expectcc.PayloadIs(getResponse, &state.CourseYear{}).(state.CourseYear)

			expectcc.ResponseOk(insertResponse)
			expectcc.ResponseOk(getResponse)
			Expect(courseYear.Year).To(Equal(2010))
			Expect(courseYear.Semester).To(Equal("odd"))
			Expect(courseYear.Status).To(Equal("end"))
		})

		It(`Drop out`, func() {
			chaincode.Invoke("Administration:startYear", 2024, "odd")
			studentId, _, _ := factory.Student("", "", 2017, "active")

			chaincode.Invoke("Administration:endYear", 2024, "odd")
			getResponse := chaincode.Query("User:getStudent", studentId)
			student := expectcc.PayloadIs(getResponse, &state.Student{}).(state.Student)

			Expect(student.Status).To(Equal("drop_out"))
		})
	})
})
