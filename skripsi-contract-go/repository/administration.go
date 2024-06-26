package repository

import (
	"strconv"

	"github.com/herbertabdillah/skripsi-contract-new/lib"
	"github.com/herbertabdillah/skripsi-contract-new/state"
)

func (r Repository) GetCourseYear(year int, semester string) (*state.CourseYear, error) {
	semesterNumber := lib.SemesterNumber(semester)

	key := "CourseYear." + strconv.Itoa(year) + strconv.Itoa(semesterNumber)
	res, err := r.context.State().Get(key, &state.CourseYear{})
	if err != nil {
		return nil, err
	}
	obj := res.(state.CourseYear)

	return &obj, nil
}

func (r Repository) GetCurrentCourseYear() (*state.CourseYear, error) {
	appConfig, err := r.GetApplicationConfig()
	if err != nil {
		return nil, err
	}

	return r.GetCourseYear(appConfig.Year, appConfig.Semester)
}

func (r Repository) GetCourseSemester(id string) (*state.CourseSemester, error) {
	res, err := r.context.State().Get("CourseSemester."+id, &state.CourseSemester{})
	if err != nil {
		return nil, err
	}
	obj := res.(state.CourseSemester)

	return &obj, nil
}

func (r Repository) InsertCourseSemester(obj *state.CourseSemester) (*state.CourseSemester, error) {
	err := r.context.State().Insert("CourseSemester."+obj.Id, obj)
	if err != nil {
		return nil, err
	}

	return obj, nil
}

func (r Repository) UpdateApplicationConfig(obj *state.ApplicationConfig) (*state.ApplicationConfig, error) {
	err := r.context.State().Put("ApplicationConfig", obj)
	if err != nil {
		return nil, err
	}

	return obj, nil
}

func (r Repository) UpdateCourseYear(obj *state.CourseYear) (*state.CourseYear, error) {
	semesterNumber := lib.SemesterNumber(obj.Semester)

	key := "CourseYear." + strconv.Itoa(obj.Year) + strconv.Itoa(semesterNumber)
	err := r.context.State().Put(key, obj)
	if err != nil {
		return nil, err
	}

	return obj, nil
}

func (r Repository) InsertCourseYear(obj *state.CourseYear) (*state.CourseYear, error) {
	semesterNumber := lib.SemesterNumber(obj.Semester)
	key := "CourseYear." + strconv.Itoa(obj.Year) + strconv.Itoa(semesterNumber)

	err := r.context.State().Insert(key, obj)

	if err != nil {
		return nil, err
	}

	return obj, nil
}

func (r Repository) SetCurrentCourseYear(year int, semester string) (*state.CourseYear, error) {
	courseYear := &state.CourseYear{Year: year, Semester: semester, Status: ""}
	key := "GlobalState.CourseSemester"

	err := r.context.State().Put(key, courseYear)

	if err != nil {
		return nil, err
	}

	return courseYear, nil
}
