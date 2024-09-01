<%@ Page Title="Admin Portal - Maintain Applications" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MaintainApplications.aspx.cs" Inherits="DriversSystem.MaintainApplications" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .table-container {
            margin: 50px auto;
            max-width: 800px;
            text-align: center;
        }
        .crud-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .crud-table th, .crud-table td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .crud-table th {
            background-color: #f8f9fa;
            font-weight: bold;
        }
        .crud-table td {
            background-color: #fff;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-control {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border: 2px solid #28a745;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .action-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .search-container {
            display: flex;
            align-items: center;
        }
        .search-container input {
            padding: 10px;
            font-size: 16px;
            border: 2px solid #28a745;
            border-radius: 5px 0 0 5px;
            box-sizing: border-box;
        }
        .search-container button {
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            background-color: #28a745;
            color: white;
            border: 2px solid #28a745;
            transition: all 0.3s ease;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
        }
        .search-container button:hover {
            background-color: white;
            color: #28a745;
            border-color: #28a745;
        }
        .custom-btn {
            padding: 15px 30px;
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
        .btn-edit {
            background-color: #ffc107;
            color: white;
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        
        .btn-delete {
            background-color: #dc3545;
            color: white;
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
    </style>

    <div class="table-container">
        <h2>Maintain Applications</h2>
    </div>

    <!-- Success Alert -->
    <asp:Panel ID="successAlert" CssClass="alert alert-success alert-dismissible fade show" runat="server" Visible="false">
        <asp:Label ID="successMessage" runat="server"></asp:Label>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <!-- Error Alert -->
    <asp:Panel ID="errorAlert" CssClass="alert alert-danger alert-dismissible fade show" runat="server" Visible="false">
        <asp:Label ID="errorMessage" runat="server"></asp:Label>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </asp:Panel>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="action-bar">
                <!-- Search Bar on the Left -->
                <div class="search-container">
                    <asp:TextBox ID="SearchTextBox" runat="server" CssClass="form-control" placeholder="Search by Application ID..." OnTextChanged="SearchTextBox_TextChanged" AutoPostBack="True"></asp:TextBox>
                    <asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="search-btn" OnClick="SearchButton_Click"/>
                </div>

                <!-- Add Button on the Right -->
                <asp:Button ID="AddApplicationButton" runat="server" Text="Add New Application" CssClass="custom-btn" postBackUrl="~/MaintainClients.aspx" />
            </div>

            <!-- GridView -->
            <asp:GridView ID="ApplicationsGridView" runat="server" AutoGenerateColumns="False" CssClass="crud-table" OnRowEditing="ApplicationsGridView_RowEditing" OnRowCancelingEdit="ApplicationsGridView_RowCancelingEdit" OnRowUpdating="ApplicationsGridView_RowUpdating">
                <Columns>
                    <asp:BoundField DataField="Application_ID" HeaderText="Application ID" />
                    <asp:BoundField DataField="IDNum" HeaderText="Client ID"  />
                     <asp:BoundField DataField="Service_Descr" HeaderText="Service"  />
                     <asp:BoundField DataField="Date" HeaderText="Date"  />
                    <asp:BoundField DataField="TimeSlot" HeaderText="Timeslot"/>
                    <asp:TemplateField HeaderText="Is Paid?">
                    <ItemTemplate>
                        <asp:CheckBox ID="IsPaidCheckBox" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsPaid")) %>' Enabled="False" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="IsPaidCheckBox" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsPaid")) %>' />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Is Attended?">
                    <ItemTemplate>
                        <asp:CheckBox ID="IsAttendedCheckBox" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsAttended")) %>' Enabled="False" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="IsAttendedCheckBox" runat="server" Checked='<%# Convert.ToBoolean(Eval("IsAttended")) %>' />
                    </EditItemTemplate>
                </asp:TemplateField>
                   <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="EditButton" runat="server" Text="Edit" CommandName="Edit" CssClass="btn btn-edit" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Button ID="UpdateButton" runat="server" Text="Update" CommandName="Update" CssClass="btn btn-update" />
                        <asp:Button ID="CancelButton" runat="server" Text="Cancel" CommandName="Cancel" CssClass="btn btn-cancel" />
                    </EditItemTemplate>
                </asp:TemplateField>

                </Columns>
            </asp:GridView> 

        </ContentTemplate>
    </asp:UpdatePanel>


</asp:Content>
