<?php

namespace Tests\Feature;

use App\Models\Student;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class StudentApiTest extends TestCase
{
    use RefreshDatabase, WithFaker;

    public function test_can_get_all_students()
    {
        Student::factory()->count(3)->create();
        $response = $this->getJson('/api/v1/students');

        $response->assertStatus(200)
                 ->assertJsonCount(3, 'data');
    }

    public function test_can_create_student()
    {
        $data = [
            'name' => 'John Doe',
            'email' => $this->faker->unique()->safeEmail, // Use unique email to avoid conflicts
            'age' => 20,
        ];
    
        $response = $this->postJson('/api/v1/students', $data);
    
        // Debug: Output status and response
        if ($response->status() !== 201) {
            \Log::error('Test failed', [
                'status' => $response->status(),
                'response' => $response->json(),
            ]);
            $this->fail('Unexpected status code: ' . $response->status());
        }
    
        $response->assertStatus(201)
                 ->assertJsonFragment($data);
        $this->assertDatabaseHas('students', $data);
    }

    public function test_can_get_student_by_id()
    {
        $student = Student::factory()->create();
        $response = $this->getJson("/api/v1/students/{$student->id}");
    
        $response->assertStatus(200)
                 ->assertJsonFragment(['name' => $student->name]);
    }
    
    public function test_can_update_student()
    {
        $student = Student::factory()->create();
        $data = ['name' => 'Updated Name'];
    
        $response = $this->putJson("/api/v1/students/{$student->id}", $data);
    
        $response->assertStatus(200)
                 ->assertJsonFragment($data);
        $this->assertDatabaseHas('students', $data);
    }
    
    public function test_can_delete_student()
    {
        $student = Student::factory()->create();
        $response = $this->deleteJson("/api/v1/students/{$student->id}");
    
        $response->assertStatus(204);
        $this->assertDatabaseMissing('students', ['id' => $student->id]);
    }
    
    public function test_healthcheck_endpoint()
    {
        $response = $this->getJson('/api/v1/healthcheck');
        $response->assertStatus(200)
                 ->assertJson(['status' => 'healthy']);
    }
}