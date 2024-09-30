defmodule ElsenderWeb.Clients.EmailControllerTest do
  use ElsenderWeb.ConnCase

  import Elsender.ClientFixtures

  @create_attrs %{name: "some name", email: "some email", phone: "some phone", getCatalog: true, getPrice: true}
  @update_attrs %{name: "some updated name", email: "some updated email", phone: "some updated phone", getCatalog: false, getPrice: false}
  @invalid_attrs %{name: nil, email: nil, phone: nil, getCatalog: nil, getPrice: nil}

  describe "index" do
    test "lists all emails", %{conn: conn} do
      conn = get(conn, ~p"/clients/emails")
      assert html_response(conn, 200) =~ "Listing Emails"
    end
  end

  describe "new email" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/clients/emails/new")
      assert html_response(conn, 200) =~ "New Email"
    end
  end

  describe "create email" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/clients/emails", email: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/clients/emails/#{id}"

      conn = get(conn, ~p"/clients/emails/#{id}")
      assert html_response(conn, 200) =~ "Email #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/clients/emails", email: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Email"
    end
  end

  describe "edit email" do
    setup [:create_email]

    test "renders form for editing chosen email", %{conn: conn, email: email} do
      conn = get(conn, ~p"/clients/emails/#{email}/edit")
      assert html_response(conn, 200) =~ "Edit Email"
    end
  end

  describe "update email" do
    setup [:create_email]

    test "redirects when data is valid", %{conn: conn, email: email} do
      conn = put(conn, ~p"/clients/emails/#{email}", email: @update_attrs)
      assert redirected_to(conn) == ~p"/clients/emails/#{email}"

      conn = get(conn, ~p"/clients/emails/#{email}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, email: email} do
      conn = put(conn, ~p"/clients/emails/#{email}", email: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Email"
    end
  end

  describe "delete email" do
    setup [:create_email]

    test "deletes chosen email", %{conn: conn, email: email} do
      conn = delete(conn, ~p"/clients/emails/#{email}")
      assert redirected_to(conn) == ~p"/clients/emails"

      assert_error_sent 404, fn ->
        get(conn, ~p"/clients/emails/#{email}")
      end
    end
  end

  defp create_email(_) do
    email = email_fixture()
    %{email: email}
  end
end
