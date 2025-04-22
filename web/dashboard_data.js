// js/admin/dashboard_data.js (Bootstrap Tabs Version with Dark Mode)

// --- Global Variables ---
const loadedTabPanes = { // Track loaded data for each tab
    'dashboard-tab-pane': false,
    'users-tab-pane': false,
    'products-tab-pane': false,
    'promotions-tab-pane': false,
    'orders-tab-pane': false,
    'reports-tab-pane': false,
    'staff-tab-pane': false
};
let currentTheme = localStorage.getItem('adminTheme') || 'light'; // Default to light
let salesChartInstance = null; // Hold the chart instance

// --- DOMContentLoaded Listener ---
document.addEventListener('DOMContentLoaded', function() {
    // Apply saved theme on initial load
    applyTheme(currentTheme);

    // Initial data load for the default active tab
    const initialActiveTab = document.querySelector('#adminTab .nav-link.active');
    const initialPaneId = initialActiveTab ? initialActiveTab.getAttribute('data-bs-target').substring(1) : 'dashboard-tab-pane';
    loadTabData(initialPaneId, true); // Force load initial tab data

    // Add event listener for Bootstrap tab changes
    const adminTabList = document.querySelectorAll('#adminTab button[data-bs-toggle="tab"]');
    adminTabList.forEach(tabEl => {
        tabEl.addEventListener('shown.bs.tab', event => {
            const targetPaneId = event.target.getAttribute('data-bs-target').substring(1);
            loadTabData(targetPaneId); // Load data for the newly shown tab if needed
        });
    });

    // Add event listener for the dark mode toggle switch
    const darkModeSwitch = document.getElementById('darkModeSwitch');
    if (darkModeSwitch) {
        darkModeSwitch.checked = (currentTheme === 'dark'); // Set initial state of switch
        updateDarkModeIcon(currentTheme); // Set initial icon

        darkModeSwitch.addEventListener('change', function() {
            const newTheme = this.checked ? 'dark' : 'light';
            applyTheme(newTheme);
        });
    } else {
        console.warn("Dark mode switch element '#darkModeSwitch' not found.");
    }
});

// --- Theme Handling Functions ---

/**
 * Applies the selected theme (light/dark) to the HTML element and saves preference.
 * @param {string} theme - The theme to apply ('light' or 'dark').
 */
function applyTheme(theme) {
    document.documentElement.setAttribute('data-bs-theme', theme);
    localStorage.setItem('adminTheme', theme);
    currentTheme = theme; // Update global variable

    // Update switch state and icon (in case theme applied programmatically)
    const darkModeSwitch = document.getElementById('darkModeSwitch');
    if (darkModeSwitch) {
        darkModeSwitch.checked = (theme === 'dark');
    }
    updateDarkModeIcon(theme);

    // Update chart theme if chart exists
    if (salesChartInstance) {
        updateChartTheme(salesChartInstance, theme);
    }
}

/**
 * Updates the dark mode toggle icon based on the current theme.
 * @param {string} theme - The current theme ('light' or 'dark').
 */
function updateDarkModeIcon(theme) {
     const iconElement = document.getElementById('darkModeIcon');
     if (iconElement) {
         if (theme === 'dark') {
             iconElement.classList.remove('fa-moon');
             iconElement.classList.add('fa-sun');
         } else {
             iconElement.classList.remove('fa-sun');
             iconElement.classList.add('fa-moon');
         }
     }
}


// --- Data Loading Logic ---

/**
 * Loads data for a specific tab pane if it hasn't been loaded yet.
 * @param {string} paneId - The ID of the tab pane.
 * @param {boolean} [forceLoad=false] - If true, forces data fetching even if already loaded.
 */
function loadTabData(paneId, forceLoad = false) {
    // Only load if not already loaded or if forced
    if (!loadedTabPanes[paneId] || forceLoad) {
        console.log(`Loading data for tab pane: ${paneId}`);
        switch(paneId) {
            case 'dashboard-tab-pane':
                fetchSalesChartData();
                fetchSummaryData();
                break;
            case 'users-tab-pane':
                console.warn("Data fetching for 'users' tab not implemented.");
                // Example: fetchUsers();
                break;
            case 'products-tab-pane':
                console.warn("Data fetching for 'products' tab not implemented.");
                // Example: fetchProducts();
                break;
            case 'promotions-tab-pane':
                 console.warn("Data fetching for 'promotions' tab not implemented.");
                 // Example: fetchPromotions();
                 break;
            case 'orders-tab-pane':
                 console.warn("Data fetching for 'orders' tab not implemented.");
                 // Example: fetchOrders();
                 break;
            case 'reports-tab-pane':
                 console.warn("Data fetching for 'reports' tab not implemented.");
                 // Example: fetchReports();
                 break;
            case 'staff-tab-pane':
                 console.warn("Data fetching for 'staff' tab not implemented.");
                 // Example: fetchStaff();
                 break;
        }
        loadedTabPanes[paneId] = true; // Mark as loaded
     } else {
         console.log(`Data for tab pane ${paneId} already loaded.`);
         // If dashboard tab is re-selected, ensure chart is visible and potentially update theme
         if (paneId === 'dashboard-tab-pane' && salesChartInstance) {
             updateChartTheme(salesChartInstance, currentTheme); // Ensure chart colors match current theme
         }
     }
}


// --- Sales Chart Functions ---
/**
 * Fetches sales data (currently uses placeholder) and renders the chart.
 */
function fetchSalesChartData() {
    const ctx = document.getElementById('salesChart');
    if (!ctx) return;

    // --- Placeholder Data Simulation ---
    console.warn("Using placeholder data for sales chart.");
    setTimeout(() => {
         const placeholderLabels = ['Apr 14', 'Apr 15', 'Apr 16', 'Apr 17', 'Apr 18', 'Apr 19', 'Apr 20'];
         const placeholderData = [120.50, 190.75, 150.00, 280.20, 210.90, 300.00, 255.50];
         renderSalesChart(ctx.getContext('2d'), placeholderLabels, placeholderData);
    }, 300);
    // --- End Placeholder Data Simulation ---
}

/**
 * Renders the sales chart using Chart.js with theme awareness.
 * @param {CanvasRenderingContext2D} context - The canvas rendering context.
 * @param {string[]} labels - Array of labels for the X-axis.
 * @param {number[]} dataPoints - Array of data points for the Y-axis.
 */
function renderSalesChart(context, labels, dataPoints) {
     if (!context) return;
    if (salesChartInstance) {
        salesChartInstance.destroy(); // Destroy previous instance
    }

    // Get theme-dependent colors
    const isDark = currentTheme === 'dark';
    const gridColor = isDark ? 'rgba(255, 255, 255, 0.15)' : 'rgba(0, 0, 0, 0.1)';
    const tickColor = isDark ? 'rgba(255, 255, 255, 0.7)' : 'rgba(0, 0, 0, 0.7)';
    const labelColor = isDark ? 'rgba(255, 255, 255, 0.9)' : 'rgba(0, 0, 0, 0.9)';
    const pointBackgroundColor = isDark ? '#6c7eff' : '#4C60DF'; // Primary color variant

    salesChartInstance = new Chart(context, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: 'Total Sales (RM)',
                data: dataPoints,
                borderColor: pointBackgroundColor, // Use theme color
                backgroundColor: isDark ? 'rgba(108, 126, 255, 0.2)' : 'rgba(76, 96, 223, 0.1)', // Adjusted fill
                borderWidth: 2,
                fill: true,
                tension: 0.1,
                pointBackgroundColor: pointBackgroundColor, // Point color
                pointBorderColor: pointBackgroundColor
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: gridColor },
                    ticks: {
                        color: tickColor,
                        callback: value => 'RM ' + value.toFixed(2)
                    }
                },
                x: {
                     grid: { color: gridColor },
                     ticks: { color: tickColor }
                }
            },
            plugins: {
                legend: {
                    display: true,
                    position: 'top',
                    labels: { color: labelColor } // Set legend label color
                },
                tooltip: {
                    bodyColor: isDark ? '#eee' : '#333', // Adjust tooltip text color
                    titleColor: isDark ? '#fff' : '#000', // Adjust tooltip title color
                    backgroundColor: isDark ? 'rgba(40, 40, 40, 0.9)' : 'rgba(255, 255, 255, 0.9)', // Tooltip background
                    borderColor: isDark ? 'rgba(100, 100, 100, 0.9)' : 'rgba(0, 0, 0, 0.1)',
                    borderWidth: 1,
                    callbacks: {
                        label: context => `${context.dataset.label || ''}: RM ${context.parsed.y.toFixed(2)}`
                    }
                }
            }
        }
    });
}

/**
 * Updates the colors of an existing Chart.js instance based on the theme.
 * @param {Chart} chart - The Chart.js instance.
 * @param {string} theme - The current theme ('light' or 'dark').
 */
function updateChartTheme(chart, theme) {
    if (!chart) return;

    const isDark = theme === 'dark';
    const gridColor = isDark ? 'rgba(255, 255, 255, 0.15)' : 'rgba(0, 0, 0, 0.1)';
    const tickColor = isDark ? 'rgba(255, 255, 255, 0.7)' : 'rgba(0, 0, 0, 0.7)';
    const labelColor = isDark ? 'rgba(255, 255, 255, 0.9)' : 'rgba(0, 0, 0, 0.9)';
    const pointBackgroundColor = isDark ? '#6c7eff' : '#4C60DF';
    const datasetFillColor = isDark ? 'rgba(108, 126, 255, 0.2)' : 'rgba(76, 96, 223, 0.1)';
    const tooltipBodyColor = isDark ? '#eee' : '#333';
    const tooltipTitleColor = isDark ? '#fff' : '#000';
    const tooltipBgColor = isDark ? 'rgba(40, 40, 40, 0.9)' : 'rgba(255, 255, 255, 0.9)';
    const tooltipBorderColor = isDark ? 'rgba(100, 100, 100, 0.9)' : 'rgba(0, 0, 0, 0.1)';

    // Update scales
    chart.options.scales.y.grid.color = gridColor;
    chart.options.scales.y.ticks.color = tickColor;
    chart.options.scales.x.grid.color = gridColor;
    chart.options.scales.x.ticks.color = tickColor;

    // Update plugins
    chart.options.plugins.legend.labels.color = labelColor;
    chart.options.plugins.tooltip.bodyColor = tooltipBodyColor;
    chart.options.plugins.tooltip.titleColor = tooltipTitleColor;
    chart.options.plugins.tooltip.backgroundColor = tooltipBgColor;
    chart.options.plugins.tooltip.borderColor = tooltipBorderColor;


    // Update dataset colors
    chart.data.datasets.forEach(dataset => {
        dataset.borderColor = pointBackgroundColor;
        dataset.backgroundColor = datasetFillColor;
        dataset.pointBackgroundColor = pointBackgroundColor;
        dataset.pointBorderColor = pointBackgroundColor;
    });

    chart.update(); // Redraw the chart with updated options
}


// --- Summary Card Functions ---
/**
 * Fetches summary data (currently uses placeholder) and updates the cards.
 */
function fetchSummaryData() {
    // --- Placeholder Data Simulation ---
    console.warn("Using placeholder data for summary cards.");
    setTimeout(() => {
        updateSummaryCard('total-users', 150);
        updateSummaryCard('total-products', 85);
        updateSummaryCard('total-orders', 520);
        updateSummaryCard('total-sales', 12345.67, 'RM');
     }, 300);
     // --- End Placeholder Data Simulation ---
}

/**
 * Updates the text content of a summary card element.
 * @param {string} elementId - The ID of the <p> element holding the value.
 * @param {number|string} value - The value to display.
 * @param {string} [prefix=''] - Optional prefix (e.g., currency symbol).
 */
function updateSummaryCard(elementId, value, prefix = '') {
    const element = document.getElementById(elementId);
    if (element) {
        let displayValue = 'N/A';
        if (value !== null && value !== undefined && value !== 'Error') {
            if (typeof value === 'number' && prefix === 'RM') {
                 displayValue = prefix + ' ' + value.toFixed(2); // Basic formatting
            } else {
                displayValue = prefix + (prefix ? ' ' : '') + value.toString();
            }
        } else if (value === 'Error') {
             displayValue = 'Error';
        }
        element.textContent = displayValue;
    }
}

// --- Placeholder functions for fetching data for other sections ---
// function fetchUsers() { console.log("Fetch Users Called"); /* Implement AJAX call and table update */ }
// function fetchProducts() { console.log("Fetch Products Called"); /* Implement AJAX call and table update */ }
// function fetchPromotions() { console.log("Fetch Promotions Called"); /* Implement AJAX call and table update */ }
// function fetchOrders() { console.log("Fetch Orders Called"); /* Implement AJAX call and table update */ }
// function fetchReports() { console.log("Fetch Reports Called"); /* Implement AJAX call and table update */ }
// function fetchStaff() { console.log("Fetch Staff Called"); /* Implement AJAX call and table update */ }

