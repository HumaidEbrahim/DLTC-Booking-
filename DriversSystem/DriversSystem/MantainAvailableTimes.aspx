<%@ Page Title="Admin Portal - Mantain Available Times" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MantainAvailableTimes.aspx.cs" Inherits="DriversSystem.MantainAvailableTimes" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        /* CSS styles remain unchanged */
    </style>

    <div class="table-container">
        <h2>Maintain Available Times</h2>
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
                    <asp:TextBox ID="SearchTextBox" runat="server" CssClass="form-control" placeholder="Search by Date or Time..." OnTextChanged="SearchTextBox_TextChanged" AutoPostBack="True"></asp:TextBox>

                    <asp:Button ID="SearchButton" runat="server" Text="Search" CssClass="search-btn" />
                </div>

                <!-- Add Button on the Right -->
                <asp:Button ID="AddAvailableTimeButton" runat="server" Text="Add New Available Time" CssClass="custom-btn" 
                    OnClientClick="$('#AddModal').modal('show'); return false;" />   
            </div>

            <!-- Get details from form for delete -->
            <script>
                function showDeleteModal(availableTimeID, availableDate, availableTime) {
                    document.getElementById('<%= DelAvailableTimeID.ClientID %>').value = availableTimeID;
                    document.getElementById('<%= HiddenDelAvailableTimeID.ClientID %>').value = availableTimeID;
                    document.getElementById('<%= DelAvailableDate.ClientID %>').value = availableDate;
                    document.getElementById('<%= DelAvailableTime.ClientID %>').value = availableTime;
                    $('#DeleteModal').modal('show');
                }
            </script>

            <!-- Get details from form for update -->
            <script>
                function showUpdateModal(availableTimeID, availableDate, availableTime) {
                    document.getElementById('<%= UpdateAvailableTimeID.ClientID %>').value = availableTimeID;
                    document.getElementById('<%= HiddenUpdateAvailableTimeID.ClientID %>').value = availableTimeID;
                    document.getElementById('<%= UpdateAvailableDate.ClientID %>').value = availableDate;
                    document.getElementById('<%= UpdateAvailableTime.ClientID %>').value = availableTime;
                    $('#UpdateModal').modal('show');
                }
            </script>

            <!-- GridView -->
            <asp:GridView ID="AvailableTimesGridView" runat="server" AutoGenerateColumns="False" CssClass="crud-table">
                <Columns>
                    <asp:BoundField DataField="AvailableTime_ID" HeaderText="ID" />
                    <asp:BoundField DataField="AvailableDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField DataField="AvailableTime" HeaderText="Time" DataFormatString="{0:HH:mm}" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="EditButton" runat="server" Text="Update" CssClass="btn btn-edit" CommandName="Edit" 
                                OnClientClick='<%# "showUpdateModal(\"" + Eval("AvailableTime_ID") + "\", \"" + Eval("AvailableDate", "{0:yyyy-MM-dd}") + "\", \"" + Eval("AvailableTime", "{0:HH:mm}") + "\"); return false;" %>' />
                            <asp:Button ID="DeleteButton" runat="server" Text="Delete" CssClass="btn btn-delete" CommandName="Delete" 
                                OnClientClick='<%# "showDeleteModal(\"" + Eval("AvailableTime_ID") + "\", \"" + Eval("AvailableDate", "{0:yyyy-MM-dd}") + "\", \"" + Eval("AvailableTime", "{0:HH:mm}") + "\"); return false;" %>' />
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
                    <h5 class="modal-title" id="deleteLabel">Delete Available Time</h5>
                </div>
                <div class="modal-body">
                    <div class="form-container">
                        <div class="form-group">
                            <label for="DelAvailableTimeID" class="form-label">Available Time ID</label>
                            <asp:TextBox ID="DelAvailableTimeID" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <asp:HiddenField ID="HiddenDelAvailableTimeID" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="DelAvailableDate" class="form-label">Available Date</label>
                            <asp:TextBox ID="DelAvailableDate" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="DelAvailableTime" class="form-label">Available Time</label>
                            <asp:TextBox ID="DelAvailableTime" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                   <asp:Button ID="ConfirmDeleteButton" runat="server" Text="Confirm Delete" CssClass="btn btn-danger" OnClick="ConfirmDeleteButton_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Update Modal -->
    <div class="modal fade" id="UpdateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="updateLabel">Update Available Time</h5>
                </div>
                <div class="modal-body">
                    <div class="form-container">
                        <div class="form-group">
                            <label for="UpdateAvailableTimeID" class="form-label">Available Time ID</label>
                            <asp:TextBox ID="UpdateAvailableTimeID" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <asp:HiddenField ID="HiddenUpdateAvailableTimeID" runat="server" />
                        </div>
                        <div class="form-group">
                            <label for="UpdateAvailableDate" class="form-label">Available Date</label>
                            <asp:TextBox ID="UpdateAvailableDate" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label for="UpdateAvailableTime" class="form-label">Available Time</label>
                            <asp:TextBox ID="UpdateAvailableTime" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="ConfirmUpdateButton" runat="server" Text="Confirm Update" CssClass="btn btn-primary" OnClick="ConfirmUpdateButton_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

