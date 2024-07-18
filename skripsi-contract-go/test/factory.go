package util

import (
	"math/rand"
	"strconv"

	testcc "github.com/hyperledger-labs/cckit/testing"
)

type Factory struct {
	Chaincode *testcc.MockStub
}

func (f Factory) Depertment(facultyId string) (string, string) {
	departmentId := "1"
	if facultyId == "" {
		facultyId = "1"
		f.Chaincode.Invoke("MasterData:insertFaculty", facultyId, "Sains dan Teknologi")
	}
	f.Chaincode.Invoke("MasterData:insertDepartment", departmentId, "Teknik Informatika", facultyId)

	return departmentId, facultyId
}

func (f Factory) Course(departmentId string) (string, string) {
	courseId := strconv.Itoa(rand.Int())
	if departmentId == "" {
		departmentId, _ = f.Depertment("")

	}

	f.Chaincode.Invoke("MasterData:insertCourse", courseId, departmentId, "Matematika dasar", 3, "class")

	return courseId, departmentId
}

func (f Factory) CourseSemester(departmentId string, courseId string, lecturerId string, year int, semester string) (string, string, string) {
	courseSemesterId := strconv.Itoa(rand.Int())
	if departmentId == "" {
		departmentId, _ = f.Depertment("")
	}
	if courseId == "" {
		courseId, _ = f.Course(departmentId)
	}
	if lecturerId == "" {
		lecturerId = f.Lecturer()
	}

	f.Chaincode.Invoke("Administration:insertCourseSemester", courseSemesterId, year, semester, courseId, lecturerId)

	return courseSemesterId, courseId, departmentId
}

func (f Factory) Lecturer() string {
	lecturerId := strconv.Itoa(rand.Int())
	f.Chaincode.Invoke("User:insertLecturer", lecturerId, "Ken Thompson", "19450002")

	return lecturerId
}

func (f Factory) Student(supervisorLecturerId string, departmentId string, entryYear int, status string) (string, string, string) {
	studentId := strconv.Itoa(rand.Int())
	if departmentId == "" {
		departmentId, _ = f.Depertment("")
	}
	if supervisorLecturerId == "" {
		supervisorLecturerId = f.Lecturer()
	}
	if status == "" {
		status = "active"
	}
	if entryYear == 0 {
		entryYear = 2017
	}
	f.Chaincode.Invoke("User:insertStudent", studentId, "Soekarno", studentId, departmentId, entryYear, status, supervisorLecturerId)

	return studentId, supervisorLecturerId, departmentId
}

func (f Factory) CoursePlan(departmentId string, studentId string, courseSemesterIds []string, year int, semester string) (string, string, string) {
	coursePlanId := strconv.Itoa(rand.Int())
	if departmentId == "" {
		departmentId, _ = f.Depertment("")
	}
	if studentId == "" {
		studentId, _, _ = f.Student("", departmentId, 0, "active")
	}
	if year == 0 {
		year = 2017
	}
	if semester == "" {
		semester = "odd"
	}

	courseSemesterIdsString := "["
	for index, element := range courseSemesterIds {
		curr := `"` + element + `"`
		courseSemesterIdsString = courseSemesterIdsString + curr
		if index+1 < len(courseSemesterIds) {
			courseSemesterIdsString = courseSemesterIdsString + ","
		}
	}
	courseSemesterIdsString = courseSemesterIdsString + "]"

	f.Chaincode.Invoke("Course:insertCoursePlan", coursePlanId, year, semester, studentId, "approved", courseSemesterIdsString)

	return coursePlanId, studentId, departmentId
}
