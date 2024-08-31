<%@ Page Title="Admin Portal - Maintain Cities" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MaintainCities.aspx.cs" Inherits="DriversSystem.MaintainCities" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <!--&nbsp;&nbsp;&nbsp;-->
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
        <h2>Maintain Cities</h2>
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
    <asp:TextBox ID="SearchTextBox" runat="server" CssClass="form-control" placeholder="Search by city..." AutoPostBack="True" style="flex: 1; margin-right: 10px;" />
    <asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="search-btn" />
</div>



                <!-- Add Button on the Right -->
                <asp:Button ID="AddCityButton" runat="server" Text="Add New City" CssClass="custom-btn" OnClientClick="$('#AddModal').modal('show'); return false;" />
            </div>

            <!-- GridView -->
            <asp:GridView ID="CitiesGridView" runat="server" AutoGenerateColumns="False" CssClass="crud-table">
                <Columns>
                    <asp:BoundField DataField="City_ID" HeaderText="City ID" />
                    <asp:BoundField DataField="Name" HeaderText="City Name" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="EditButton" runat="server" Text="Update" CssClass="btn btn-edit" CommandName="Edit" 
                                OnClientClick='<%# "showUpdateModal(\"" + Eval("City_ID") + "\", \"" + Eval("Name") + "\"); return false;" %>' />
                            <asp:Button ID="DeleteButton" runat="server" Text="Delete" CssClass="btn btn-delete" CommandName="Delete" 
                                OnClientClick='<%# "showDeleteModal(\"" + Eval("City_ID") + "\", \"" + Eval("Name") + "\"); return false;" %>' />
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
                    <h5 class="modal-title" id="deleteLabel">Delete City</h5>
                </div>
                <div class="modal-body">
                    <div class="form-container">
                        <div class="form-group">
                            <label for="DelCityID" class="form-label">City ID</label>
                            <asp:TextBox ID="DelCityID" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <asp:HiddenField ID="HiddenDelCityID" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="DelCityName" class="form-label">City Name</label>
                            <asp:TextBox ID="DelCityName" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <asp:Button ID="DeleteCityButton" runat="server" Text="Delete" CssClass="custom-btn" OnClick="DeleteCityButton_Click" />
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
                    <h5 class="modal-title" id="updateLabel">Update City</h5>
                </div>
                <div class="modal-body">
                    <div class="form-container">
                        <div class="form-group">
                            <label for="UpdateCityID" class="form-label">City ID</label>
                            <asp:TextBox ID="UpdateCityID" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <asp:HiddenField ID="HiddenUpdateCityID" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="UpdateCityName" class="form-label">City Name</label>
                            <asp:TextBox ID="UpdateCityName" runat="server" CssClass="form-control" Enabled="true"></asp:TextBox>
                            <span id="UpdateNameWarning" class="text-danger" style="display: none;">City Name must be between 1 and 35 characters.</span>
                        </div>
                    </div>
                </div>

                <div class="modal-footer">
                    <asp:Button ID="UpdateCityButton" runat="server" Text="Update" CssClass="custom-btn" OnClick="UpdateCityButton_Click" OnClientClick="return validateForm('update','UpdateNameWarning') && true;" />
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
                    <h5 class="modal-title" id="exampleModalLabel">Add City</h5>
                </div>
                <div class="modal-body">
                    <div class="form-container">
                        <p>Enter city details below:</p>
                        <div class="form-group">
                            <label for="AddCityName" class="form-label">City Name</label>
                            <asp:TextBox ID="AddCityName" runat="server" CssClass="form-control" MaxLength="35"></asp:TextBox>
                            <span id="AddNameWarning" class="text-danger" style="display: none;">City Name must be between 1 and 35 characters.</span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="SaveCityButton" runat="server" Text="Add" CssClass="custom-btn" OnClick="SaveCityButton_Click" OnClientClick="return validateForm('add','AddNameWarning') && true;" />
                    <asp:Button ID="Button4" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#AddModal').modal('hide'); return false;" />
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function validateForm(mode, warningId) {
            var cityName;
            if (mode === 'add') {
                cityName = document.getElementById('<%= AddCityName.ClientID %>').value;
            } else {
                cityName = document.getElementById('<%= UpdateCityName.ClientID %>').value;
            }

            if (cityName.trim().length < 1 || cityName.trim().length > 35) {
                document.getElementById(warningId).style.display = "inline";
                return false;
            } else {
                document.getElementById(warningId).style.display = "none";
            }

            return true;
        }

        function showUpdateModal(cityID, cityName) {
            document.getElementById('<%= UpdateCityID.ClientID %>').value = cityID;
            document.getElementById('<%= HiddenUpdateCityID.ClientID %>').value = cityID;
            document.getElementById('<%= UpdateCityName.ClientID %>').value = cityName;

            $('#UpdateModal').modal('show');
        }

        function showDeleteModal(cityID, cityName) {
            document.getElementById('<%= DelCityID.ClientID %>').value = cityID;
            document.getElementById('<%= HiddenDelCityID.ClientID %>').value = cityID;
            document.getElementById('<%= DelCityName.ClientID %>').value = cityName;

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
