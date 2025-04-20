// js/admin/dashboard_data.js

document.addEventListener('DOMContentLoaded', function() {
    // Fetch and Render Chart
    fetchSalesChartData();

    // Fetch and Render Summary Cards
    fetchSummaryData();
});

// --- Sales Chart Functions ---

function fetchSalesChartData() {
    const ctx = document.getElementById('salesChart');
    if (!ctx) {
        console.error("Sales chart canvas element not found.");
        return; // Exit if chart canvas not found
    }

    // --- TODO: Replace this with a real fetch call ---
    // Example: fetch('/e-commerce-system/admin/stats/sales') // Adjust context path
    //     .then(response => {
    //         if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
    //         return response.json();
    //      })
    //     .then(data => {
    //         // Assuming data = { labels: [...], data: [...] }
    //         renderSalesChart(ctx.getContext('2d'), data.labels, data.data);
    //     })
    //     .catch(error => {
    //         console.error('Error fetching sales data:', error);
    //         renderSalesChart(ctx.getContext('2d'), ['Error'], [0]); // Render error state
    //     });

    // --- Placeholder Chart Data (Remove when using fetch) ---
    console.warn("Using placeholder data for sales chart. Implement backend fetch.");
    setTimeout(() => { // Simulate loading delay
         const placeholderLabels = ['Apr 14', 'Apr 15', 'Apr 16', 'Apr 17', 'Apr 18', 'Apr 19', 'Apr 20'];
         const placeholderData = [120.50, 190.75, 150.00, 280.20, 210.90, 300.00, 255.50];
         renderSalesChart(ctx.getContext('2d'), placeholderLabels, placeholderData);
    }, 500);
    // --- End Placeholder ---
}

function renderSalesChart(context, labels, dataPoints) {
     if (!context) {
        console.error("Chart context is missing for rendering!");
        return;
    }
    // Destroy previous chart instance if it exists to prevent conflicts
    if (window.mySalesChart instanceof Chart) {
        window.mySalesChart.destroy();
    }

    // Create new chart instance
    window.mySalesChart = new Chart(context, {
        type: 'line', // Type of chart
        data: {
            labels: labels, // Labels for the X-axis (e.g., dates)
            datasets: [{
                label: 'Total Sales (RM)', // Label for the dataset
                data: dataPoints,         // Data points for the Y-axis
                borderColor: '#4C60DF', // Line color (use your primary color)
                backgroundColor: 'rgba(76, 96, 223, 0.1)', // Area fill color (lighter primary)
                borderWidth: 2,           // Line thickness
                fill: true,               // Fill area under the line
                tension: 0.1              // Line curve (0 for straight lines)
            }]
        },
        options: {
            responsive: true, // Make chart responsive
            maintainAspectRatio: false, // Allow custom sizing via CSS container
            scales: {
                y: { // Y-axis configuration
                    beginAtZero: true, // Start Y-axis at 0
                    ticks: {
                        // Format Y-axis labels as currency
                        callback: function(value) {
                            // Adjust currency symbol and formatting as needed
                            return 'RM ' + value.toFixed(2);
                        }
                    }
                }
                // Add X-axis configuration if needed
                // x: { ... }
            },
            plugins: {
                legend: {
                    display: true, // Show legend
                    position: 'top', // Position legend at the top
                },
                tooltip: { // Tooltip configuration
                    callbacks: {
                        // Format tooltip content
                        label: function(context) {
                            let label = context.dataset.label || '';
                            if (label) { label += ': '; }
                            if (context.parsed.y !== null) {
                                // Format value as currency
                                label += 'RM ' + context.parsed.y.toFixed(2);
                            }
                            return label;
                        }
                    }
                }
            }
        }
    });
}

// --- Summary Card Functions ---

function fetchSummaryData() {
    // --- TODO: Implement fetch call to a backend endpoint ---
    // This endpoint should return JSON like:
    // { totalUsers: 150, totalProducts: 85, totalOrders: 520, totalSalesMonth: 12345.67 }
    // Example: fetch('/e-commerce-system/admin/stats/summary') // Adjust context path
    //     .then(response => response.json())
    //     .then(summaryData => {
    //         updateSummaryCard('total-users', summaryData.totalUsers);
    //         updateSummaryCard('total-products', summaryData.totalProducts);
    //         updateSummaryCard('total-orders', summaryData.totalOrders);
    //         updateSummaryCard('total-sales', summaryData.totalSalesMonth, 'RM'); // Add prefix
    //     })
    //     .catch(error => {
    //         console.error('Error fetching summary data:', error);
    //         updateSummaryCard('total-users', 'Error');
    //         updateSummaryCard('total-products', 'Error');
    //         updateSummaryCard('total-orders', 'Error');
    //         updateSummaryCard('total-sales', 'Error');
    //     });

    // --- Placeholder Summary Data (Remove when using fetch) ---
    console.warn("Using placeholder data for summary cards. Implement backend fetch.");
    setTimeout(() => { // Simulate loading delay
        updateSummaryCard('total-users', 150);
        updateSummaryCard('total-products', 85);
        updateSummaryCard('total-orders', 520);
        updateSummaryCard('total-sales', 12345.67, 'RM');
     }, 500);
     // --- End Placeholder ---
}

function updateSummaryCard(elementId, value, prefix = '') {
    const element = document.getElementById(elementId);
    if (element) {
        let displayValue = 'N/A'; // Default if value is invalid
        if (value !== null && value !== undefined && value !== 'Error') {
            if (typeof value === 'number' && prefix === 'RM') {
                // Format currency
                displayValue = prefix + ' ' + value.toLocaleString('en-MY', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
            } else {
                displayValue = prefix + (prefix ? ' ' : '') + value.toString();
            }
        } else if (value === 'Error') {
             displayValue = 'Error';
        }
        element.textContent = displayValue;
    } else {
        console.warn(`Summary card element with ID "${elementId}" not found.`);
    }
}

