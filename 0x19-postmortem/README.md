## Postmortem: Web Stack Debugging Project Outage

### Issue Summary:

On June 4, 2023, from 2:00 PM to 3:30 PM GMT, our web application experienced a 90-minute service interruption. This outage impacted our API service, resulting in delayed responses and timeouts for approximately 25% of our users. The root cause was an unexpected memory overflow issue in our Nginx server.

# Timeline:

- **2:00 PM:** Issue detected by automated system monitoring alert, indicating abnormal memory usage on the server.
- **2:10 PM:** Incident escalated to the on-duty DevOps engineer. Initial inspection of server logs indicated high memory consumption.
- **2:30 PM:** False lead pursued, as memory issue initially assumed to be due to increased user traffic. Extra resources allocated to cope with assumed increased demand.
- **2:45 PM:** Incident escalated to senior DevOps team after added resources did not mitigate the problem. 
- **3:00 PM:** Detailed examination of the server logs led to identification of a memory leak in the Nginx server.
- **3:30 PM:** A patch was applied to fix the memory leak, and the service resumed normal operation.

# Root Cause and Resolution:

The root cause was a memory leak in the Nginx server, which escalated into a memory overflow, causing the service outage. Due to the unexpected nature of the leak, it was initially attributed to increased traffic, leading to a delay in the correct identification of the problem.

The resolution involved applying a patch to fix the memory leak. After the patch was applied, the server was restarted, which resolved the memory overflow and the service was restored to normal.

# Corrective and Preventative Measures:

This incident exposed the need for improved monitoring and quicker issue identification. The measures to be taken include:

- **Patch and update the Nginx server**: The current memory leak patch needs to be applied to all other servers to prevent a similar occurrence. All servers also need to be updated to the latest stable version of Nginx to leverage any other fixes or improvements.
- **Improve server memory monitoring**: Enhance the granularity of memory usage tracking in the automated monitoring system. Alerts should be more nuanced, distinguishing between typical high usage and potential memory leaks.
- **Incident response protocol**: We need to revise the incident response protocol to include immediate escalation of similar issues to senior engineers, bypassing initial lower-level troubleshooting when automated alerts indicate potential memory leaks.
