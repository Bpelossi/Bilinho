require "test_helper"

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get invoices_url
    assert_response :success
  end

  test "should get new" do
    get new_invoice_url
    assert_response :success
  end

  test "should show invoice" do
    invoice = invoices(:one)
    get invoice_url(invoice)
    assert_response :success
  end

  test "should get edit" do
    invoice = invoices(:one)
    get edit_invoice_url(invoice)
    assert_response :success
  end

  test "should create invoice" do
    assert_difference("Invoice.count") do
      post invoices_url, params: { invoice: { invoice_price: 9.99, invoice_due_date: "2025-06-21", enrollment_id: enrollments(:one).id, status: "open" } }
    end
    assert_redirected_to invoice_url(Invoice.last)
  end

  test "should update invoice" do
    invoice = invoices(:one)
    patch invoice_url(invoice), params: { invoice: { status: "paid" } }
    assert_redirected_to invoice_url(invoice)
  end

  test "should destroy invoice" do
    invoice = invoices(:one)
    assert_difference("Invoice.count", -1) do
      delete invoice_url(invoice)
    end
    assert_redirected_to invoices_url
  end
end
