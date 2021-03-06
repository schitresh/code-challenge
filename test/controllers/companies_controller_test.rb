require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text @company.city
    assert_text @company.state
  end

  test "Update" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      fill_in("company_email", with: "new_test_company@test.com")
      click_button "Update Company"
    end

    assert_text "Email should have domain '@getmainstreet.com'"

    within("form#edit_company_#{@company.id}") do
      fill_in("company_zip_code", with: "930091")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Update Company"
    end

    assert_text "Zip code is not valid"

    within("form#edit_company_#{@company.id}") do
      fill_in("company_zip_code", with: "93009")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "93009", @company.zip_code
    assert_equal "new_test_company@getmainstreet.com", @company.email
  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@test.com")
      click_button "Create Company"
    end

    assert_text "Email should have domain '@getmainstreet.com'"

    within("form#new_company") do
      fill_in("company_zip_code", with: "281731")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    assert_text "Zip code is not valid"

    within("form#new_company") do
      fill_in("company_zip_code", with: "28173")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
    assert_equal "new_test_company@getmainstreet.com", last_company.email
  end

  test "Destroy" do
    visit edit_company_path(@company)

    accept_alert do
      click_link "Delete Company" do
        assert_difference('Company.count', -1)
      end
    end
  end
end
