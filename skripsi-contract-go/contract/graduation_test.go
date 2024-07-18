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

func TestGraduation(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "Graduation")
}

var _ = Describe(`Course`, func() {
	var chaincode *testcc.MockStub
	var factory testhelper.Factory
	BeforeEach(func() {
		chaincode = testcc.NewMockStub(`contract`, contract.NewCC())
		factory = testhelper.Factory{Chaincode: chaincode}
		chaincode.Invoke("MasterData:init")
	})

	Describe(`Graduate`, func() {
		When(`student havent dont all course`, func() {
			It(`return error and not update student`, func() {
				departmentId, _ := factory.Depertment("")

				chaincode.Invoke("Administration:startYear", 2017, "odd")
				courseSemesterId1, _, _ := factory.CourseSemester(departmentId, "", "", 2017, "odd")
				courseSemesterId2, _, _ := factory.CourseSemester(departmentId, "", "", 2017, "odd")
				courseSemesterId3, _, _ := factory.CourseSemester(departmentId, "", "", 2017, "odd")
				coursePlanId, studentId, _ := factory.CoursePlan(departmentId, "", []string{courseSemesterId1, courseSemesterId2, courseSemesterId3}, 2017, "odd")
				chaincode.Invoke("Course:updateCourseResult", courseSemesterId1, coursePlanId, "3")
				chaincode.Invoke("Course:updateCourseResult", courseSemesterId2, coursePlanId, "3")
				chaincode.Invoke("Course:updateCourseResult", courseSemesterId3, coursePlanId, "1")
				chaincode.Invoke("Administration:endYear", 2017, "odd")

				chaincode.Invoke("Administration:startYear", 2018, "even")

				graduateResponse := chaincode.Invoke("Graduation:graduate", studentId)

				expectcc.ResponseError(graduateResponse)
				queryResponse := chaincode.Query("User:getStudent", studentId)
				student := expectcc.PayloadIs(queryResponse, &state.Student{}).(state.Student)
				Expect(student.Status).To(Equal("active"))
			})
		})

		It(`update student status`, func() {
			departmentId, _ := factory.Depertment("")

			chaincode.Invoke("Administration:startYear", 2017, "odd")
			courseSemesterId1, _, _ := factory.CourseSemester(departmentId, "", "", 2017, "odd")
			courseSemesterId2, _, _ := factory.CourseSemester(departmentId, "", "", 2017, "odd")
			courseSemesterId3, _, _ := factory.CourseSemester(departmentId, "", "", 2017, "odd")
			coursePlanId, studentId, _ := factory.CoursePlan(departmentId, "", []string{courseSemesterId1, courseSemesterId2, courseSemesterId3}, 2017, "odd")
			chaincode.Invoke("Course:updateCourseResult", courseSemesterId1, coursePlanId, "3")
			chaincode.Invoke("Course:updateCourseResult", courseSemesterId2, coursePlanId, "3")
			chaincode.Invoke("Course:updateCourseResult", courseSemesterId3, coursePlanId, "3")
			chaincode.Invoke("Administration:endYear", 2017, "odd")

			chaincode.Invoke("Administration:startYear", 2018, "even")

			graduateResponse := chaincode.Invoke("Graduation:graduate", studentId)

			expectcc.ResponseOk(graduateResponse)
			queryResponse := chaincode.Query("User:getStudent", studentId)
			student := expectcc.PayloadIs(queryResponse, &state.Student{}).(state.Student)
			Expect(student.Status).To(Equal("graduated"))
			Expect(student.ExitYear).To(Equal(2018))
		})
	})
})
