<%@ Page Title="Maintain Clients - edit or delete appkication" Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ClientPortal_MaintainApplications.aspx.cs" Inherits="DriversSystem.ClientPortal_MaintainApplications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style>
        .form-container {
            background-color: white;
            border: 2px solid black;
            border-radius: 10px;
            padding: 30px;
            max-width: 600px;
            margin: 0 auto;
            margin-top: 50px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .form-heading {
            font-size: 28px;
            color: #28a745;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-label {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .dropdown-control {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            background-color: white;
            color: #333;
        }

        .btn {
            padding: 15px 30px;
            font-size: 18px;
            font-weight: bold;
            border-radius: 5px;
            width: 48%;
            margin: 10px 1%;
            text-align: center;
            display: inline-block;
        }

        .btn-primary {
            background-color: #ffc107;
            color: white;
            border: 2px solid #ffc107;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: white;
            color: #ffc107;
        }

        .btn-success {
            background-color: #28a745;
            color: white;
            border: 2px solid #28a745;
            transition: all 0.3s ease;
        }

        .btn-success:hover {
            background-color: white;
            color: #28a745;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
            border: 2px solid #dc3545;
            transition: all 0.3s ease;
        }

        .btn-danger:hover {
            background-color: white;
            color: #dc3545;
        }

        .button-group {
            text-align: center;
            margin-top: 20px;
        }

        
        .calendar-container {
            text-align: center; 
            margin-bottom: 15px;
        }

        .continue-btn {
            padding: 15px 30px;
            font-size: 18px;
            font-weight: bold;
            background-color: #28a745;
            color: white;
            border: 2px solid #28a745;
            transition: all 0.3s ease;
            display: block;
            text-align: center;
            text-decoration: none;
            margin: 20px auto 0;
            border-radius: 5px;
            width: 100%;
        }

        .continue-btn:hover {
            background-color: white;
            color: #28a745;
        }

        .timeslot-group {
            margin-bottom: 15px;
        }

         .calendar a {
            text-decoration: none;
            color: black; 
        }

        .calendar a:hover {
            color: #28a745;
        }

        td.no_underline a
         {
             text-decoration:none;
         }
         td.no_underline a:active
         {
            text-decoration: none;
         }

         .calendar-container {
    border-radius: 15px;
    overflow: hidden;
    border: 1px solid #ccc;
    width: fit-content;
    margin: 0 auto;
   
    background-color: #198754; 
    text-decoration: none;
}

.calendar-container td, .calendar-container th {
    text-align: center;
    padding: 10px;
    border: 0.5px solid #ddd; 
    text-decoration: none;
     background-color: #198754;
}


.calendar-container .calendar-header {
    background-color: #198754;
    color: white;
    padding: 10px;
    font-weight: bold;
    border-radius: 0px 0px 0 0;
    text-align: center;
    text-decoration: none;
}


.calendar-container .calendar-day-header {
    background-color: #e9ecef; 
    color: #495057; 
    font-weight: bold;
    text-decoration: none;
}

.calendar-container .calendar-day, .calendar-container .calendar-weekend-day {
    background-color: white;
    color: #333;
    text-decoration:none;
}

.calendar-container .calendar-today {
    background-color: #28a745;
    color: white;
    font-weight: bold;
    
    text-decoration: none;
}

.calendar-container .calendar-selected {
    background-color: #17a2b8; 
    color: white;
    text-decoration: none;
}

.calendar-container .calendar-weekend-day {
    background-color: #f8f9fa;
    color: #dc3545;
    text-decoration: none;
}
    </style>
           <!-- Delete Confirm Modal -->
<div class="modal fade" id="DeleteConfirmModal" tabindex="-1" role="dialog" aria-labelledby="deleteconfirmLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteconfirmLabel">Are you sure you want to delete?</h5>
            </div>
            <div class="modal-footer">
                <asp:Button ID="DeleteConfirmButton" runat="server" Text="Confirm Delete" CssClass="custom-btn" OnClick="DeleteConfirmButton_Click" />
                <asp:Button ID="CancelDeleteButton" runat="server" Text="Cancel" CssClass="custom-btn" OnClientClick="$('#DeleteConfirmModal').modal('hide'); return false;" />
            </div>
        </div>
    </div>
</div>
            <!-- Error Alert -->
    <asp:Panel ID="errorAlert" CssClass="alert alert-danger alert-dismissible fade show" runat="server" Visible="false">
    <asp:Label ID="errorMessage" runat="server"></asp:Label>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
</asp:Panel>
    <div class="form-container">
        <h2 class="form-heading">Edit or Delete Application Details</h2>

            <div class="form-group">
        <label for="IDNumber" class="form-label">ID Number</label>
        <asp:TextBox ID="IDNumber" runat="server" CssClass="form-control" Enabled="False"></asp:TextBox>
    </div>
    <asp:Panel ID="FormState" runat="server" Enabled="false"> 
    <div class="form-group">
        <label for="Service" class="form-label">Select Service</label>
        <asp:DropDownList ID="ServiceDropdown" runat="server" CssClass="form-control">
           
        </asp:DropDownList>
    </div>
   
     <div class="calendar-container">
    <asp:Calendar ID="calendar" runat="server" OnSelectionChanged="calendar_SelectionChanged"
        DayStyle-Font-Underline="false"
        DayStyle-Font-Overline="false"
        TodayDayStyle-Font-Underline="false"
        DayStyle-CssClass="calendar-day"
        TodayDayStyle-CssClass="calendar-today"
        SelectedDayStyle-CssClass="calendar-selected"
        WeekendDayStyle-CssClass="calendar-weekend-day"
        TitleStyle-CssClass="calendar-header"
        DayHeaderStyle-CssClass="calendar-day-header">
    </asp:Calendar>

</div>
    <br /> 
    <div class="form-group timeslot-group">
        <asp:label ID="Label1"  runat="server" Visible="true"/>
        <label for="SelectTimeslot" class="form-label">Select Timeslot</label>
          <asp:label ID="NoTimes" Text="No available times for the selected date." runat="server" Visible="false"/>
        <asp:RadioButtonList ID="TimeslotRadioButtonList" runat="server" RepeatDirection="Vertical" CssClass="form-control"> </asp:RadioButtonList>
    </div>
         </asp:Panel>
            <asp:Panel ID="ClientDetailsPanel" runat="server" CssClass="button-group">
        <asp:Button ID="UpdateButton" runat="server" Text="Edit" CssClass="btn btn-primary" OnClick="UpdateButton_Click" />
        <asp:Button ID="SaveButton" runat="server" Text="Save" CssClass="btn btn-success" OnClick="SaveButton_Click" Visible="false" />
                   <asp:Button ID="DeleteButton" runat="server" Text="Delete" CssClass="btn btn-danger" OnClientClick="$('#DeleteConfirmModal').modal('show'); return false;" OnClick="DeleteButton_Click"  />
        </asp:Panel>
    </div>

     
   
</asp:Content>

