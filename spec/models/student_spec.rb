require 'spec_helper'

describe Student do

  it "has a valid factory" do 
    expect(FactoryGirl.build(:student)).to be_valid 
  end

  it "should require an email address" do
    expect(FactoryGirl.build(:student, email: nil)).to_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[admin@foo.com THE_admin@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_student = FactoryGirl.build(:student, :email => address)
      expect(valid_email_student).to be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[admin@foo,com admin_at_foo.org example.admin@foo.]
    addresses.each do |address|
      invalid_email_student = FactoryGirl.build(:student, :email => address)
      expect(invalid_email_student).to_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    FactoryGirl.create(:student, email: "abc123@abc.com")
    student_with_duplicate_email = FactoryGirl.build(:student, email: "abc123@abc.com")
    expect(student_with_duplicate_email).to_not be_valid
  end

  it "should reject email addresses identical up to case" do
    FactoryGirl.create(:student, :email => "ABC@ABC.COM")
    student_with_duplicate_email = FactoryGirl.build(:student, email: "abc@abc.com")
    expect(student_with_duplicate_email).to_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @student = FactoryGirl.build(:student)
    end

    it "should have a password attribute" do
      expect(@student).to respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      expect(@student).to respond_to(:password_confirmation)
    end
  end

  describe "password validations" do

    it "should require a password" do
      expect(FactoryGirl.build(:student, :password => "", :password_confirmation => "")).to_not be_valid
    end

    it "should require a matching password confirmation" do
      expect(FactoryGirl.build(:student, :password_confirmation => "invalid")).to_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      expect(FactoryGirl.build(:student, :password => short, :password_confirmation => short)).to_not be_valid
    end

  end

  describe "password encryption" do

    before(:each) do
      @student = FactoryGirl.create(:student)
    end

    it "should have a password_digest attribute" do
      expect(@student).to respond_to(:password_digest)
    end
  end

end
