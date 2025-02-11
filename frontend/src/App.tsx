import { useState, useEffect } from "react";
import "./App.css";
import axios from "axios";

type Student = {
    id: string;
    name: string;
    classification: number;
};

const BACKEND_URL_BASE = "http://localhost:5000";

function App() {
    const [studentList, setStudentList] = useState<Student[]>([]);
    const [student, setStudent] = useState<Student | null>(null);
    const [upsertStatus, setUpsertStatus] = useState<number | null>(null);
    const [deleteStatus, setDeleteStatus] = useState<number | null>(null);
    const [updateClassificationStatus, setUpdateClassificationStatus] =
        useState<number | null>(null);
    const [randomGuid, setRandomGuid] = useState<string | null>(null);

    // Fetch all students when the page loads
    useEffect(() => {
        const fetchStudents = async () => {
            try {
                const url = `${BACKEND_URL_BASE}/students`;
                const { data, status } = await axios.get<Student[]>(url);

                if (status !== 200) throw new Error("Failed to fetch students");

                setStudentList(data);

                // Get a random GUID from the list of students
                if (data.length > 0) {
                    const randomStudent = data[Math.floor(Math.random() * data.length)];
                    setRandomGuid(randomStudent.id);
                }
            } catch (error) {
                console.error("Error fetching students:", error);
            }
        };

        fetchStudents();
    }, []); // Run once when the component mounts

    const getStudentById = async (id: string) => {
        const url = `${BACKEND_URL_BASE}/student/${id}`;
        const { data, status } = await axios.get<Student>(url);

        if (status !== 200) throw new Error("Failed to fetch student");

        setStudent(data);
    };

    const upsertStudent = async (student: Student) => {
        const url = `${BACKEND_URL_BASE}/student`;
        const { status } = await axios.post(url, student);

        if (status !== 200) throw new Error("Failed to upsert student");

        setUpsertStatus(status);
    };

    const deleteStudent = async (id: string) => {
        const url = `${BACKEND_URL_BASE}/student/${id}`;
        const { status } = await axios.delete(url);

        if (status !== 200) throw new Error("Failed to delete student");

        // Remove deleted student from the list
        setStudentList((prevList) => prevList.filter((student) => student.id !== id));

        setDeleteStatus(status);
    };

    const updateStudentClassification = async (
        id: string,
        classification: number
    ) => {
        const url = `${BACKEND_URL_BASE}/student/${id}/${classification}`;
        const { status } = await axios.put(url);

        if (status !== 200)
            throw new Error("Failed to update student classification");

        setUpdateClassificationStatus(status);
    };

    return (
        <div className="app">
            <div className="endpoint-test-container">
                <button
                    onClick={() => {
                        const fetchStudents = async () => {
                            try {
                                const url = `${BACKEND_URL_BASE}/students`;
                                const { data, status } = await axios.get<Student[]>(url);

                                if (status !== 200) throw new Error("Failed to fetch students");

                                setStudentList(data);

                                // Get a random GUID from the list of students
                                if (data.length > 0) {
                                    const randomStudent = data[Math.floor(Math.random() * data.length)];
                                    setRandomGuid(randomStudent.id);
                                }
                            } catch (error) {
                                console.error("Error fetching students:", error);
                            }
                        };

                        fetchStudents();
                    }}
                >
                    Verify GetStudents Works
                </button>

                {studentList.length > 0 && (
                    <p>Students: {studentList.length}</p>
                )}
            </div>

            <div className="endpoint-test-container">
                <button
                    onClick={() => {
                        getStudentById(randomGuid!);
                    }}
                >
                    Verify GetStudentById Works
                </button>

                {student && <p>Student: {student.name}</p>}
            </div>

            <div className="endpoint-test-container">
                <button
                    onClick={() => {
                        upsertStudent({
                            id: randomGuid!,
                            name: "John Doe",
                            classification: 1,
                        });
                    }}
                >
                    Verify UpsertStudent Works
                </button>

                {upsertStatus && <p>Student Upserted</p>}
            </div>

            <div className="endpoint-test-container">
                <button
                    onClick={() => {
                        deleteStudent(randomGuid!);
                    }}
                >
                    Verify DeleteStudent Works
                </button>

                {deleteStatus && <p>Student Deleted</p>}
            </div>

            <div className="endpoint-test-container">
                <button
                    onClick={() => {
                        updateStudentClassification(randomGuid!, 2);
                    }}
                >
                    Verify UpdateStudentClassification Works
                </button>

                {updateClassificationStatus && (
                    <p>Student Classification Updated</p>
                )}
            </div>
        </div>
    );
}

export default App;
