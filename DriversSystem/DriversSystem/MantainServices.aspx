<%@ Page Title="Admin Portal - Mantain Services" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MantainServices.aspx.cs" Inherits="DriversSystem.MantainServices" %>


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
        .btn {
            padding: 6px 12px;
            font-size: 14px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .btn-edit {
            background-color: #ffc107;
            color: white;
        }
        .btn-delete {
            background-color: #dc3545;
            color: white;
        }
        .btn-add, .btn-csv {
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 5px;
            margin-right: 10px;
            cursor: pointer;
            border: none;
            color: white;
        }
        .btn-add {
            background-color: #28a745;
        }
        .btn-csv {
            background-color: #007bff;
        }
    </style>

    <div class="table-container">
        <h2>Maintain Services</h2>

        <asp:GridView ID="ServicesGridView" runat="server" AutoGenerateColumns="False" CssClass="crud-table">
            <Columns>
                <asp:BoundField DataField="ServiceID" HeaderText="Service ID" />
                <asp:BoundField DataField="ServiceDescription" HeaderText="Service Description" />
                <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />

                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <asp:Button ID="EditButton" runat="server" Text="Edit" CssClass="btn btn-edit" CommandName="Edit" />
                        <asp:Button ID="DeleteButton" runat="server" Text="Del" CssClass="btn btn-delete" CommandName="Delete" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <div>
            <asp:Button ID="DownloadCsvButton" runat="server" Text="Download CSV" CssClass="btn-csv" />
            <asp:Button ID="AddServiceButton" runat="server" Text="Add Service" CssClass="btn-add" />
        </div>
    </div>
</asp:Content>
