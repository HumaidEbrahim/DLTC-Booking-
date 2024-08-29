<%@ Page Title="Admin Portal - Reports" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="IncomeReport.aspx.cs" Inherits="DriversSystem.IncomeReport" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .report-container {
            margin: 20px auto;
            max-width: 1200px;
            padding: 20px;
            background-color: #f9f9f9;
            border: 1px solid #ccc;
            border-radius: 10px;
        }

        .report-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .report-header h1 {
            color: #28a745;
            margin-bottom: 5px;
        }

        .report-header .timestamp {
            font-size: 14px;
            color: #555;
        }

        .section-title {
            font-size: 20px;
            color: #28a745;
            margin-top: 20px;
            margin-bottom: 10px;
        }

        .report-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .report-table th, .report-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .report-table th {
            background-color: #f8f9fa;
            font-weight: bold;
        }

        .report-table td {
            background-color: #fff;
        }

        .total-row {
            font-weight: bold;
            background-color: #f1f1f1;
        }

        .grand-total-row {
            font-weight: bold;
            background-color: #e0e0e0;
        }

        .report-footer {
            text-align: center;
            margin-top: 30px;
            font-size: 14px;
            color: #555;
        }

        .filter-section {
            margin-bottom: 20px;
        }

        .filter-section .form-group {
            display: inline-block;
            margin-right: 15px;
        }

        .page-number {
            text-align: right;
            font-size: 12px;
            color: #555;
            margin-top: 10px;
        }
    </style>

    <div class="report-container">
        <!-- Report Header -->
        <div class="report-header">
            <h1>Income Per Time Period Report</h1>
            <div class="timestamp">
                <asp:Label ID="lblDateTime" runat="server"></asp:Label>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <h2>Filter by Date</h2>
            <div class="form-group">
                <label for="startDate">Start Date:</label>
                <asp:TextBox ID="StartDateTextBox" runat="server" CssClass="form-control datepicker" placeholder="Select Start Date"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="endDate">End Date:</label>
                <asp:TextBox ID="EndDateTextBox" runat="server" CssClass="form-control datepicker" placeholder="Select End Date"></asp:TextBox>
            </div>
            <asp:Button ID="FilterButton" runat="server" Text="Filter" CssClass="btn btn-primary" OnClick="FilterButton_Click" />
        </div>

        <!-- Report Section: Income Per Time Period -->
        <h2 class="section-title">Income Per Time Period</h2>
        <asp:GridView ID="gvIncomeReport" runat="server" CssClass="report-table" AutoGenerateColumns="False" ShowFooter="True" AllowPaging="True" PageSize="10" OnRowDataBound="gvIncomeReport_RowDataBound" OnPageIndexChanging="gvIncomeReport_PageIndexChanging">
            <Columns>
                <asp:BoundField DataField="Service" HeaderText="Service" />
                <asp:BoundField DataField="ServicePrice" HeaderText="Service Price" DataFormatString="{0:C2}" />
                <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C2}" />
            </Columns>
            <FooterStyle CssClass="grand-total-row" />
            <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" />
            <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
        </asp:GridView>

        <!-- Page Number -->
        <div class="page-number">
            Page <asp:Label ID="lblCurrentPage" runat="server"></asp:Label> of <asp:Label ID="lblTotalPages" runat="server"></asp:Label>
        </div>

        <!-- Report Footer -->
        <div class="report-footer">
            <p>End of Report</p>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".datepicker").datepicker({
                dateFormat: "dd-mm-yy",
                changeMonth: true,
                changeYear: true,
                showAnim: "slideDown"
            });
        });
    </script>
</asp:Content>