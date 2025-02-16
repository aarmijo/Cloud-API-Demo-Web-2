# DJI Cloud API Demo Web

The web interface will be available at [http://localhost:8080/project](http://localhost:8080/project)  
Login Credentials: 

&nbsp;&nbsp;&nbsp;&nbsp;Username: **adminPC**  
&nbsp;&nbsp;&nbsp;&nbsp;Password: **adminPC**

---

## Configuration

### 1. Register as a DJI Developer

1. Register at the [DJI Developer Center](https://account.dji.com/register?appId=dji_sdk&backUrl=https%3A%2F%2Fdeveloper.dji.com%2Fuser&locale=en_US).
2. Create a new application:
   - Go to the [Developer Center](https://developer.dji.com/user) → **Apps** → **Create App**.
   - Select **Cloud API** as App Type.
   - Fill in the required information.
   - Wait for the activation email.

### 2. Set up Environment Variables

Create a `.env.secret` file in the root directory with your DJI application credentials:

```env
VITE_APP_ID=<your_app_id>
VITE_APP_KEY=<your_app_key>
VITE_APP_LICENSE=<your_app_license>
```

Replace the placeholders with the values from your DJI Developer account.

---

## Services

The Docker Compose setup includes:

- **Web Frontend**: Vue.js application (served via NPM; internally listens on port 3000 and reverse-proxied through Nginx on port 8080)
- **Cloud API**: Spring Boot backend (port 6789)
- **EMQX**: MQTT broker (ports 1883, 8083, 8084, 8883, 18083)
- **MySQL**: Database (port 3306)
- **Redis**: Cache (port 6379)

_Note: All service containers are networked via `dji_cloud_web_network` and can communicate using their service names._

---

## Running the Application using Docker

We've provided a script (`startup.sh`) to simplify startup by:

- Automatically extracting the host's LAN IP (compatible with both macOS and Linux).
- Overriding the environment variables (namely `VITE_BASE_URL` and `VITE_WEBSOCKET_URL`) so that your application's status endpoint reports the proper host IP and externally bound Nginx port.

### How to Run

1. **Make the Startup Script Executable (if not already):**

   ```bash
   chmod +x startup.sh
   ```

2. **Run the Startup Script:**

   ```bash
   ./startup.sh
   ```

   The script will:

   - Detect your host's LAN IP.
   - Set the environment variables:
     - `VITE_BASE_URL` as `http://<host_ip>:8080/`
     - `VITE_WEBSOCKET_URL` as `ws://<host_ip>:8080/api/v1/ws`
   - Start all Docker containers as defined in the `docker-compose.yml`.

---

## Connecting DJI Pilot 2

1. Open DJI Pilot 2.
2. Navigate to **Cloud Services**.
3. Click **Open Platforms** in the bottom right.
4. Enter: `http://<your_host_ip>:8080/pilot-login` (Replace `<your_host_ip>` with your LAN IP)
5. Click **Connect**.
6. Login with:
   - Username: **pilot**
   - Password: **pilot123**

---

## Development Setup (Local)

If you prefer to run services locally without Docker, refer to the [DJI Developer Documentation](https://developer.dji.com/doc/cloud-api-tutorial/cn/) for detailed setup instructions.

### Prerequisites for Local Development

- Node.js and npm
- Java Development Kit (JDK)
- MySQL
- Redis
- EMQX

---

## Latest Official DJI Release

The official DJI Cloud API 1.10.0 was released on 7 April 2024. For more information, please visit the [Release Note](https://developer.dji.com/doc/cloud-api-tutorial/cn/).

### Spantree Fork Enhancements

This fork is maintained by [Spantree, LLC](https://spantree.net) and includes first-class Docker support for easier deployment. Key improvements include:

- **Containerized Deployment**: Complete Docker and Docker Compose configuration.
- **Environment Management**: Improved environment variable handling with TypeScript support.
- **Dependency Updates**: Removed problematic mirror dependencies for better build reliability.
- **Service Integration**: Pre-configured supporting services (MySQL, Redis, EMQX).

Pre-built Docker containers are available on Docker Hub:

- Frontend: [spantree/dji-cloud-api-demo-web](https://hub.docker.com/repository/docker/spantree/dji-cloud-api-demo-web)
- Backend: [spantree/dji-cloud-api-sample](https://hub.docker.com/repository/docker/spantree/dji-cloud-api-sample)

For detailed changelog information, please refer to the repository commit history.

---

## License

This project is MIT-licensed. Please refer to the LICENSE file for more information.
