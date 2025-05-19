package model.bean;

public class city {
    private int id;
    private String city_name;
    private String[] district;

    public city() {
    }

    public city(int id, String city_name, String[] district) {
        this.id = id;
        this.city_name = city_name;
        this.district = district;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCity_name() {
        return city_name;
    }

    public void setCity_name(String city_name) {
        this.city_name = city_name;
    }

    public String[] getDistrict() {
        return district;
    }

    public void setDistrict(String[] district) {
        this.district = district;
    }
}
