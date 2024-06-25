from locust import HttpUser, task

class AisLoadTest(HttpUser):
    # def on_start(self):
    #     self.client.get("/admin/login?email=admin@example.com")

    @task
    def get_course_plan(self):
        # self.client.get("/admin/course_plans/144")
        self.client.get("/api/course_plans/144")
