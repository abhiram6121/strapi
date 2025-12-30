# Unleash Feature Management

Unleash allows you to toggle features in your app instantly without redeploying code.

## 1. Local Server Setup (Docker)
Run this command to start the Unleash dashboard and database:
```bash
git clone git@github.com:Unleash/unleash.git
cd unleash
docker compose up -d
```

- Dashboard: http://localhost:4242
- Login: `admin` / `unleash4all`
- Setup: Create a flag named `my-feature` and toggle it ON in the Development environment.

## 2. React Application Setup

### Install SDK
```bash
npm install @unleash/proxy-client-react
```

### Configure Provider (main.jsx)
Wrap your app with the FlagProvider.

```javascript
import { FlagProvider } from '@unleash/proxy-client-react';

const config = {
  url: 'http://localhost:4242/api/frontend',
  clientKey: 'default:development.unleash-insecure-frontend-api-token',
  appName: 'my-react-app',
  refreshInterval: 5,
};

// Wrap <App /> with <FlagProvider config={config}>
```

### Component Implementation
Use the `useFlag` hook to conditionally render your UI.

```javascript
import { useFlag } from '@unleash/proxy-client-react';

export const FeatureComponent = () => {
  const enabled = useFlag('my-feature');
  
  return (
    <div>
      {enabled ? <h1>🚀 New Feature Active!</h1> : <h1>Standard View</h1>}
    </div>
  );
}
```