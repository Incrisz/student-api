<?php
namespace App\Http\Controllers\API\V1;

use App\Http\Controllers\Controller;
use App\Models\Student;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Http\JsonResponse;

class StudentController extends Controller
{
    public function index(): JsonResponse
    {
        Log::info('Fetching all students');
        $students = Student::all();
        return response()->json(['data' => $students], 200);
    }

    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:students',
            'age' => 'required|integer|min:1',
        ]);

        Log::info('Creating new student', $validated);
        $student = Student::create($validated);
        return response()->json(['data' => $student], 201);
    }

    public function show($id): JsonResponse
    {
        Log::info("Fetching student with ID: {$id}");
        $student = Student::find($id);

        if (!$student) {
            Log::warning("Student with ID: {$id} not found");
            return response()->json(['message' => 'Student not found'], 404);
        }

        return response()->json(['data' => $student], 200);
    }

    public function update(Request $request, $id): JsonResponse
    {
        $student = Student::find($id);

        if (!$student) {
            Log::warning("Student with ID: {$id} not found for update");
            return response()->json(['message' => 'Student not found'], 404);
        }

        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'email' => 'sometimes|email|unique:students,email,' . $id,
            'age' => 'sometimes|integer|min:1',
        ]);

        Log::info("Updating student with ID: {$id}", $validated);
        $student->update($validated);
        return response()->json(['data' => $student], 200);
    }

    public function destroy($id): JsonResponse
    {
        Log::info("Deleting student with ID: {$id}");
        $student = Student::find($id);

        if (!$student) {
            Log::warning("Student with ID: {$id} not found for deletion");
            return response()->json(['message' => 'Student not found'], 404);
        }

        $student->delete();
        return response()->json(['message' => 'Student deleted'], 204);
    }
}