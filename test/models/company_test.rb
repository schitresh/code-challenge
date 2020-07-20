require "test_helper"
require "application_system_test_case"
require "minitest/autorun"

class CompanyTest < ApplicationSystemTestCase
    def setup
        @company = companies(:hometown_painting)
        @company_details = { name: "New Test Company", zip_code: "93003", phone: "5553335555", email: "new_test_company@getmainstreet.com" }
    end

    test "Validate Email" do
        @company_new = Company.create(@company_details)
        assert @company_new.valid?

        @company_details[:email] = "new_test_company@test.com"
        @company_new = Company.create(@company_details)
        assert_not @company_new.valid?

        @company.update(email: "new_test_company@getmainstreet.com")
        assert @company.valid?

        @company.update(email: "new_test_company@test.com")
        assert_not @company.valid?
    end

    test "Check Zip Code" do
        @company_new = Company.create(@company_details)
        assert @company_new.valid?

        @company_details[:zip_code] = "123456"
        @company_new = Company.create(@company_details)
        assert_not @company_new.valid?

        assert @company.valid?
        @company.update(zip_code: "123456")
        assert_not @company.valid?

        @company.update(zip_code: "93003")
        assert @company.valid?
    end

    test "Update Address" do
        @company_new = Company.create(@company_details)

        assert_equal @company_new.city, "Ventura"
        assert_equal @company_new.state, "CA"

        @company.update!(zip_code: "94003")

        assert_equal @company.city, "Belmont"
        assert_equal @company.state, "CA"
    end

    test "Get Address" do
        @company.get_address()

        assert_equal @company.city, "Ventura"
        assert_equal @company.state, "CA"
    end
end