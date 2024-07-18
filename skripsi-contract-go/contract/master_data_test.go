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

func TestMasterData(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "MasterData")
}

var _ = Describe(`MasterData`, func() {
	var chaincode *testcc.MockStub
	var factory testhelper.Factory
	BeforeEach(func() {
		chaincode = testcc.NewMockStub(`contract`, contract.NewCC())
		factory = testhelper.Factory{Chaincode: chaincode}
		chaincode.Invoke("MasterData:init")
	})

	Describe(`insertFaculty`, func() {
		It(`insert faculty data`, func() {
			insertResponse := chaincode.Invoke("MasterData:insertFaculty", "1", "Sains dan Teknologi")
			getResponse := chaincode.Query("MasterData:getFaculty", "1")
			faculty := expectcc.PayloadIs(getResponse, &state.Faculty{}).(state.Faculty)

			expectcc.ResponseOk(insertResponse)
			expectcc.ResponseOk(getResponse)
			Expect(faculty.Name).To(Equal("Sains dan Teknologi"))
		})
	})

	Describe(`insertDepartment`, func() {
		It(`insert department data`, func() {
			chaincode.Invoke("MasterData:insertFaculty", "1", "Sains dan Teknologi")

			insertResponse := chaincode.Invoke("MasterData:insertDepartment", "1", "Teknik Informatika", "1")
			getResponse := chaincode.Query("MasterData:getDepartment", "1")
			department := expectcc.PayloadIs(getResponse, &state.Department{}).(state.Department)

			expectcc.ResponseOk(insertResponse)
			expectcc.ResponseOk(getResponse)
			Expect(department.Name).To(Equal("Teknik Informatika"))
			Expect(department.FacultyId).To(Equal("1"))
		})
	})

	Describe(`insertCourse`, func() {
		It(`insert course data`, func() {
			departmentId, _ := factory.Depertment("")

			insertResponse := chaincode.Invoke("MasterData:insertCourse", "2", departmentId, "Matematika dasar", 3, "class")
			getResponse := chaincode.Query("MasterData:getCourse", "2")
			course := expectcc.PayloadIs(getResponse, &state.Course{}).(state.Course)

			expectcc.ResponseOk(insertResponse)
			expectcc.ResponseOk(getResponse)
			Expect(course.Name).To(Equal("Matematika dasar"))
			Expect(course.Credit).To(Equal(3))
			Expect(course.DepartmentId).To(Equal(departmentId))
			Expect(course.Kind).To(Equal("class"))
		})
	})
})
