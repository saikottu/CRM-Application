// sendmail.js
$(document).ready(function () {
    $('.report-btn').on('click', function (e) {
        e.preventDefault();

        $.ajax({
            url: "/CRMv2/pages/customer%20management/scheduletask_mails/sendmail.cfm",
            type: "POST",
            data: {
                name: "sai",
                email: "sai@example.com"
            },
            success: function () {
                alert("Mail sent successfully. Click OK to open the PDF.");
                window.open("http://localhost:8500/CRMv2/pages/customer management/customer_report/customer_report.cfm", "_blank");
            },
            error: function (xhr) {
                console.error("AJAX error:", xhr.status, xhr.statusText);
                console.error("Response:", xhr.responseText);
                alert("Failed to send email. Please try again.");
            }
        });
    });
});
