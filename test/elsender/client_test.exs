defmodule Elsender.ClientTest do
  use Elsender.DataCase

  alias Elsender.Client

  describe "emails" do
    alias Elsender.Client.Email

    import Elsender.ClientFixtures

    @invalid_attrs %{name: nil, email: nil, phone: nil, getCatalog: nil, getPrice: nil}

    test "list_emails/0 returns all emails" do
      email = email_fixture()
      assert Client.list_emails() == [email]
    end

    test "get_email!/1 returns the email with given id" do
      email = email_fixture()
      assert Client.get_email!(email.id) == email
    end

    test "create_email/1 with valid data creates a email" do
      valid_attrs = %{name: "some name", email: "some email", phone: "some phone", getCatalog: true, getPrice: true}

      assert {:ok, %Email{} = email} = Client.create_email(valid_attrs)
      assert email.name == "some name"
      assert email.email == "some email"
      assert email.phone == "some phone"
      assert email.getCatalog == true
      assert email.getPrice == true
    end

    test "create_email/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Client.create_email(@invalid_attrs)
    end

    test "update_email/2 with valid data updates the email" do
      email = email_fixture()
      update_attrs = %{name: "some updated name", email: "some updated email", phone: "some updated phone", getCatalog: false, getPrice: false}

      assert {:ok, %Email{} = email} = Client.update_email(email, update_attrs)
      assert email.name == "some updated name"
      assert email.email == "some updated email"
      assert email.phone == "some updated phone"
      assert email.getCatalog == false
      assert email.getPrice == false
    end

    test "update_email/2 with invalid data returns error changeset" do
      email = email_fixture()
      assert {:error, %Ecto.Changeset{}} = Client.update_email(email, @invalid_attrs)
      assert email == Client.get_email!(email.id)
    end

    test "delete_email/1 deletes the email" do
      email = email_fixture()
      assert {:ok, %Email{}} = Client.delete_email(email)
      assert_raise Ecto.NoResultsError, fn -> Client.get_email!(email.id) end
    end

    test "change_email/1 returns a email changeset" do
      email = email_fixture()
      assert %Ecto.Changeset{} = Client.change_email(email)
    end
  end
end
