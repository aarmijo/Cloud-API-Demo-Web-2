/// <reference types="vite/client" />

interface ImportMetaEnv {
  // readonly VITE_APP_ENVIRONMENT: "DEV" | "STAG" | "UAT" | "PROD";

  // Required license values
  readonly VITE_APP_ID: string;
  readonly VITE_APP_KEY: string;
  readonly VITE_APP_LICENSE: string;

  // Required HTTP values
  readonly VITE_BASE_URL: string;
  readonly VITE_WEBSOCKET_URL: string;

  // Optional livestreaming values
  readonly VITE_RTMP_URL?: string;
  readonly VITE_GB_SERVER_IP?: string;
  readonly VITE_GB_SERVER_PORT?: string;
  readonly VITE_GB_SERVER_ID?: string;
  readonly VITE_GB_AGENT_ID?: string;
  readonly VITE_GB_PASSWORD?: string;
  readonly VITE_GB_AGENT_PORT?: string;
  readonly VITE_GB_AGENT_CHANNEL?: string;
  readonly VITE_RTSP_USERNAME?: string;
  readonly VITE_RTSP_PASSWORD?: string;
  readonly VITE_RTSP_PORT?: string;
  readonly VITE_AGORA_APP_ID?: string;
  readonly VITE_AGORA_TOKEN?: string;
  readonly VITE_AGORA_CHANNEL?: string;

  // Optional map values
  readonly VITE_AMAP_KEY?: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
