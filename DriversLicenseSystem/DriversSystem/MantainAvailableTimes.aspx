<%@ Page Title="Admin Portal - Mantain Available Times" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MantainAvailableTimes.aspx.cs" Inherits="DriversSystem.MantainAvailableTimes" %>


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
        <h2>Manage Available Times</h2>
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
                <div class="search-container" style="display: flex; align-items: center;">
                    <asp:TextBox ID="SearchTextBox" runat="server" CssClass="form-control" placeholder="Search by date..." AutoPostBack="True" style="flex: 1; margin-right: 10px;" />
                    <asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="search-btn" />
                </div>

                <!-- Add Button on the Right -->
                <asp:Button ID="AddTimeButton" runat="server" Text="Add New Time Slot" CssClass="custom-btn" OnClientClick="$('#AddModal').modal('show'); return false;" />
            </div>

            <!-- GridView -->
            <asp:GridView ID="TimesGridView" runat="server" AutoGenerateColumns="False" CssClass="crud-table">
                <Columns>
                    <asp:BoundField DataField="Time_ID" HeaderText="Time ID" />
                    <asp:BoundField DataField="Date" HeaderText="Date" />
                    <asp:BoundField DataField="StartTime" HeaderText="Start Time" />
                    <asp:BoundField DataField="EndTime" HeaderText="End Time" />
                    <asp:BoundField DataField="NumPeopleAllowed" HeaderText="Number of People Allowed" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="EditButton" runat="server" Text="Update" CssClass="btn btn-edit" CommandName="Edit" 
                                OnClientClick='<%# "showUpdateModal(\"" + Eval("Time_ID") + "\", \"" + Eval("Date") + "\", \"" + Eval("StartTime") + "\", \"" + Eval("EndTime") + "\", \"" + Eval("NumPeopleAllowed") + "\"); return false;" %>' />
                            <asp:Button ID="DeleteButton" runat="server" Text="Delete" CssClass="btn btn-delete" CommandName="Delete" 
                                OnClientClick='<%# "showDeleteModal(\"" + Eval("Time_ID") + "\", \"" + Eval("Date") + "\"); return false;" %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>

    <!-- Delete Modal -->
    <div class="modal fade" id="DeleteModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteLabel">Delete Time Slot</h5>
                </div>
                <div class="modal-body">
                    <div class="form-container">
                        <div class="form-group">
                            <label for="DelTimeID" class="form-label">Time ID</label>
                            <asp:TextBox ID="DelTimeID" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <asp:HiddenField ID="HiddenDelTimeID" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="DelDate" class="form-label">Date</label>
                            <asp:TextBox ID="DelDate" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <asp:Button ID="DeleteTimeButton" runat="server" Text="Delete" CssClass="custom-btn" OnClick="DeleteTimeButton_Click" />
                    <asp:Button ID="Button2" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#DeleteModal').modal('hide'); return false;" />
                </div>
            </div>
        </div>
    </div>

    <!-- Update Modal -->
    <div class="modal fade" id="UpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateLabel">Update Time Slot</h5>
                </div>
                <div class="modal-body">
                    <div class="form-container">
                        <div class="form-group">
                            <label for="UpdateTimeID" class="form-label">Time ID</label>
                            <asp:TextBox ID="UpdateTimeID" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <asp:HiddenField ID="HiddenUpdateTimeID" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="UpdateDate" class="form-label">Date</label>
                            <asp:TextBox ID="UpdateDate" runat="server" CssClass="form-control" Enabled="true"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="UpdateStartTime" class="form-label">Start Time</label>
                            <asp:TextBox ID="UpdateStartTime" runat="server" CssClass="form-control" Enabled="true"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="UpdateEndTime" class="form-label">End Time</label>
                            <asp:TextBox ID="UpdateEndTime" runat="server" CssClass="form-control" Enabled="true"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="UpdateNumPeopleAllowed" class="form-label">Number of People Allowed</label>
                            <asp:TextBox ID="UpdateNumPeopleAllowed" runat="server" CssClass="form-control" Enabled="true"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <asp:Button ID="UpdateTimeButton" runat="server" Text="Update" CssClass="custom-btn" OnClick="UpdateTimeButton_Click" />
                    <asp:Button ID="Button3" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#UpdateModal').modal('hide'); return false;" />
                </div>
            </div>
        </div>
    </div>

<!-- Add Modal -->
<div class="modal fade" id="AddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Time Slot</h5>
            </div>
            <div class="modal-body">
                <div class="form-container">
                    <div class="form-group">
                        <label for="AddDate" class="form-label">Date</label>
                        <asp:TextBox ID="AddDate" runat="server" CssClass="form-control" TextMode="Date" />
                    </div>
                    <div class="form-group">
                        <label for="AddStartTime" class="form-label">Start Time</label>
                        <asp:TextBox ID="AddStartTime" runat="server" CssClass="form-control" TextMode="Time" />
                    </div>
                    <div class="form-group">
                        <label for="AddEndTime" class="form-label">End Time</label>
                        <asp:TextBox ID="AddEndTime" runat="server" CssClass="form-control" TextMode="Time" />
                    </div>
                    <div class="form-group">
                        <label for="AddNumPeopleAllowed" class="form-label">Number of People Allowed</label>
                        <asp:TextBox ID="AddNumPeopleAllowed" runat="server" CssClass="form-control" />
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <asp:Button ID="SaveTimeButton" runat="server" Text="Add" CssClass="custom-btn" OnClick="SaveTimeButton_Click" />
                <asp:Button ID="Button4" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#AddModal').modal('hide'); return false;" />
            </div>
        </div>
    </div>
</div>

    <script type="text/javascript">
        function showUpdateModal(timeID, date, startTime, endTime, numPeopleAllowed) {
            document.getElementById('<%= UpdateTimeID.ClientID %>').value = timeID;
            document.getElementById('<%= HiddenUpdateTimeID.ClientID %>').value = timeID;
            document.getElementById('<%= UpdateDate.ClientID %>').value = date;
            document.getElementById('<%= UpdateStartTime.ClientID %>').value = startTime;
            document.getElementById('<%= UpdateEndTime.ClientID %>').value = endTime;
            document.getElementById('<%= UpdateNumPeopleAllowed.ClientID %>').value = numPeopleAllowed;

            $('#UpdateModal').modal('show');
        }

        function showDeleteModal(timeID, date) {
            document.getElementById('<%= DelTimeID.ClientID %>').value = timeID;
            document.getElementById('<%= HiddenDelTimeID.ClientID %>').value = timeID;
            document.getElementById('<%= DelDate.ClientID %>').value = date;

            $('#DeleteModal').modal('show');
        }

        $(document).ready(function () {
            // Initialize tooltips
            $('[data-toggle="tooltip"]').tooltip();
        });

    </script>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</asp:Content>
