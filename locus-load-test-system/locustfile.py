from locust import HttpUser, task
import random

class AisLoadTest(HttpUser):
    # def on_start(self):
    #     self.client.get("/admin/login?email=admin@example.com")

    @task
    def get_course_plan(self):
        # self.client.get("/api/course_plans/144")
        id = random.randint(1, 100)
        self.client.get(f"/api/departments/{id}", name = "/api/departments/:id")

    @task
    def insert_department(self):
        self.client.post("/api/departments", name = "/api/departments")
