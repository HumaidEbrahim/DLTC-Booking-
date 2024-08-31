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

        .grand-total-row {
            font-weight: bold;
            text-align: right;
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

        .filter-section .sort-options {
            margin-top: 10px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .sort-options label {
            margin-right: 10px;
            font-weight: bold;
            color: #333;
        }

        .page-number {
            text-align: right;
            font-size: 12px;
            color: #555;
            margin-top: 10px;
        }

        .custom-btn {
            padding: 5px 10px;
            font-size: 18px;
            font-weight: bold;
            background-color: #28a745;
            color: white;
            border: 2px solid #28a745;
            transition: all 0.3s ease;
            display: inline-block;
            text-align: center;
            text-decoration: none;
            margin: 15px;
            border-radius: 5px;
            min-width: 200px;
        }

        .custom-btn:hover {
            background-color: white;
            color: #28a745;
            border-color: #28a745;
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
                <asp:TextBox ID="StartDateTextBox" TextMode="Date" runat="server" CssClass="form-control datepicker" placeholder="Select Start Date"></asp:TextBox>
            </div>
           
            <div class="form-group">
                <label for="endDate">End Date:</label>
                <asp:TextBox ID="EndDateTextBox" TextMode="Date" runat="server" CssClass="form-control datepicker" placeholder="Select End Date"></asp:TextBox>
            </div>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="form-group">
                        <asp:Button ID="FilterButton" runat="server" Text="Filter" CssClass="custom-btn" OnClick="FilterButton_Click" />
                    </div>

                    <!-- Sort Options -->
                    <div class="sort-options">
                        <label for="sortOrder">Sort By Total:</label>
                        <asp:RadioButtonList ID="sortOrder" runat="server" RepeatDirection="Horizontal" CssClass="sort-order">
                            <asp:ListItem Text="Lowest" Value="ASC" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Highest" Value="DESC"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>

                    <!-- Report Section: Income Per Time Period -->
                    <asp:Label ID="reportHeading" runat="server" CssClass="section-title">Income Per Time Period</asp:Label>
                    <asp:GridView ID="IncomeGridView" runat="server" CssClass="report-table" AutoGenerateColumns="False" ShowFooter="True" OnRowDataBound="IncomeGridView_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="Service_Descr" HeaderText="Service" />
                            <asp:BoundField DataField="Price" HeaderText="Service Price" DataFormatString="{0:C0}" />
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" />
                            <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C0}" />
                        </Columns>
                        <FooterStyle CssClass="grand-total-row" />
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <!-- Report Footer -->
        <div class="report-footer">
            Page 1/1 
            <p>End of Report</p>
        </div>
    </div>
</asp:Content>
