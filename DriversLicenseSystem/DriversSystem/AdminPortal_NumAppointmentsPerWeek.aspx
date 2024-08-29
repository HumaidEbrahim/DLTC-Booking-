<%@ Page Title="Admin Portal - Reports" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="AdminPortal_NumAppointmentsPerWeek.aspx.cs" Inherits="DriversSystem.AdminPortal_NumAppointmentsPerWeek" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .report-container {
            margin: 20px auto;
            max-width: 1000px;
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

        .report-footer {
            text-align: center;
            margin-top: 30px;
            font-size: 14px;
            color: #555;
        }

        .page-number {
            text-align: center;
            font-size: 14px;
            color: #555;
            margin-top: 10px;
        }

        .total-row {
            font-weight: bold;
            background-color: #f1f1f1;
        }
    </style>


    <div class="report-container">
        <!-- Report Header -->
        <div class="report-header">
            <h1>Number of Appointments Per Week</h1>
            <div class="timestamp">
                <asp:Label ID="lblDateTime" runat="server"></asp:Label>
            </div>
        </div>

        <!-- Dtae -->
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

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

        <!-- Report Section: Detailed Appointments Report -->
        <h2 class="section-title">Detailed Appointments Report</h2>
        <asp:GridView ID="gvAppointmentsReport" runat="server" CssClass="report-table" AutoGenerateColumns="False" AllowPaging="True" PageSize="10" OnPageIndexChanging="gvAppointmentsReport_PageIndexChanging" OnRowDataBound="gvAppointmentsReport_RowDataBound" OnSelectedIndexChanged="gvAppointmentsReport_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="Week" HeaderText="Week" />
                <asp:BoundField DataField="StartDate" HeaderText="Start Date" DataFormatString="{0:MM/dd/yyyy}" />
                <asp:BoundField DataField="EndDate" HeaderText="End Date" DataFormatString="{0:MM/dd/yyyy}" />
                <asp:BoundField DataField="AppointmentCount" HeaderText="Number of Appointments" />
            </Columns>
            <FooterStyle CssClass="total-row" />
            <PagerSettings Mode="NumericFirstLast" PageButtonCount="5" FirstPageText="First" LastPageText="Last" />
        </asp:GridView>

        <!-- Report Footer -->
        <div class="report-footer">
            <p>End of Report</p>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            $(".datepicker").datepicker({
                dateFormat: "dd-mm-yy", // Format: day-month-year
                changeMonth: true,
                changeYear: true,
                showAnim: "slideDown"
            });
        });
    </script>
</asp:Content>
