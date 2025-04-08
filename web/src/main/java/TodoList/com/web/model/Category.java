package TodoList.com.web.model;

public class Category {
    private int categoryID;
    private String name;
    private String color;

    public Category() {
    }

    public Category(int categoryID, String name, String color) {
        this.categoryID = categoryID;
        this.name = name;
        this.color = color;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }
}
