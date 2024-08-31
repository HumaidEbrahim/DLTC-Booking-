<%@ Page Title="Admin Portal - Reports" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="AdminPortal_NumAppointmentsPerWeek.aspx.cs" Inherits="DriversSystem.AdminPortal_NumAppointmentsPerWeek" %>

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
            text-align: center;
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

        .sort-options {
            margin-top: 10px;
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
            <h1>Number of Appointments Per Week</h1>
            <div class="timestamp">
                <asp:Label ID="lblDateTime" runat="server"></asp:Label>
            </div>
        </div>

        <!-- Filter Section -->
        <div class="filter-section">
            <h2>Filter by Date</h2>
            <div class="form-group">
                <label for="startDate">Start Date:</label>
                <asp:TextBox ID="StartDateTextBox" runat="server" TextMode="Date" CssClass="form-control datepicker" placeholder="Select Start Date"></asp:TextBox>
            </div>
            <div class="form-group">
                <label for="endDate">End Date:</label>
                <asp:TextBox ID="EndDateTextBox" runat="server" TextMode="Date" CssClass="form-control datepicker" placeholder="Select End Date"></asp:TextBox>
            </div>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <div class="form-group">
                        <asp:Button ID="FilterButton" runat="server" Text="Filter" CssClass="custom-btn" OnClick="FilterButton_Click" />
                    </div>

                    <!-- Sort Options -->
                    <div class="sort-options">
                        <label for="sortOrder">Sort By:</label>
                        <asp:RadioButtonList ID="SortOrderRadioButtonList" runat="server" RepeatDirection="Horizontal" CssClass="sort-order">
                            <asp:ListItem Text="Ascending" Value="ASC" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Descending" Value="DESC"></asp:ListItem>
                        </asp:RadioButtonList>
                    </div>

                    <!-- Report Section: Weekly Appointments Report -->
                    <h2 class="section-title">Weekly Appointments Report</h2>
                    <asp:GridView ID="ApplicationGridView" runat="server" CssClass="report-table" AutoGenerateColumns="False" ShowFooter="True">
                        <Columns>
                            <asp:BoundField DataField="TimeSlot" HeaderText="Time Slot"/>
                            <asp:BoundField DataField="Week1" HeaderText="Week 1" />
                            <asp:BoundField DataField="Week2" HeaderText="Week 2" />
                            <asp:BoundField DataField="Week3" HeaderText="Week 3" />
                            <asp:BoundField DataField="Week4" HeaderText="Week 4" />
                            <asp:BoundField DataField="Week5" HeaderText="Week 5" />
                            <asp:BoundField DataField="TotalApplication" HeaderText="Total Appointments" />
                        </Columns>
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
