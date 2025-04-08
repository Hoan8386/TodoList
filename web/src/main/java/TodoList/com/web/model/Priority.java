package TodoList.com.web.model;

public class Priority {
    private int priorityID; // ID của mức độ ưu tiên
    private String name; // Tên của mức độ ưu tiên

    // Getters and Setters
    public int getPriorityID() {
        return priorityID;
    }

    public void setPriorityID(int priorityID) {
        this.priorityID = priorityID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Constructor
    public Priority() {
    }

    public Priority(int priorityID, String name) {
        this.priorityID = priorityID;
        this.name = name;
    }

    @Override
    public String toString() {
        return "Priority{" +
                "priorityID=" + priorityID +
                ", name='" + name + '\'' +
                '}';
    }
}
