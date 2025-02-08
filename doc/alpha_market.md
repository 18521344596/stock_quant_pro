Alpha Vantage 提供了一个股票市场行情数据的 API，可以用来获取股票、外汇、加密货币等多个金融市场的实时和历史数据。以下是一些关于如何使用 Alpha Vantage API 获取股票市场行情的基本信息和示例。

### **1. 注册获取 API 密钥**

首先，访问 [Alpha Vantage 网站](https://www.alphavantage.co/support/#api-key) 注册并获取一个免费的 API 密钥。你将需要这个密钥来进行 API 调用。

已经获取到密钥：AK2O35BXMH40KL8T

### **2. 可用的股票数据接口**

Alpha Vantage 提供了多个 API 来获取股票市场数据，以下是一些常用的接口：

#### **(a) 获取股票的实时数据（Time Series）**

- **URL**：

  ```
  https://www.alphavantage.co/query
  ```
- **参数**：

  - `function`: 你要查询的功能。对于股票数据，可以使用 `TIME_SERIES_INTRADAY`、`TIME_SERIES_DAILY`、`TIME_SERIES_WEEKLY` 等。
  - `symbol`: 股票的代码，例如：`MSFT`（Microsoft）或 `AAPL`（Apple）。
  - `interval`: 时间间隔，`TIME_SERIES_INTRADAY` 类型时使用，常见的值有：`1min`、`5min`、`15min`、`30min`、`60min`。
  - `apikey`: 你的 API 密钥。
- **示例 URL**：

  ```text
  https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&apikey=your_api_key
  ```

#### **(b) 获取股票的历史数据（例如，日线数据）**

- **URL**：

  ```
  https://www.alphavantage.co/query
  ```
- **参数**：

  - `function`: 使用 `TIME_SERIES_DAILY`、`TIME_SERIES_WEEKLY`、`TIME_SERIES_MONTHLY`。
  - `symbol`: 股票代码（例如 `AAPL`、`GOOG`）。
  - `outputsize`: 数据量，`compact`（最近 100 个数据点）或 `full`（所有可用数据）。
  - `apikey`: 你的 API 密钥。
- **示例 URL**：

  ```text
  https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=AAPL&outputsize=compact&apikey=your_api_key
  ```

#### **(c) 获取股票的技术指标（Technical Indicators）**

Alpha Vantage 提供了多种技术指标（例如，RSI、MACD、SMA等）来帮助分析股票市场。

- **URL**：

  ```
  https://www.alphavantage.co/query
  ```
- **参数**：

  - `function`: 要查询的技术指标，例如 `SMA`、`EMA`、`RSI`、`MACD` 等。
  - `symbol`: 股票代码（例如 `AAPL`）。
  - `interval`: 时间间隔，常见的值有：`1min`、`5min`、`15min`、`30min`、`60min`。
  - `time_period`: 特定时间段，例如 14（常用于 RSI）。
  - `apikey`: 你的 API 密钥。
- **示例 URL**：

  ```text
  https://www.alphavantage.co/query?function=RSI&symbol=AAPL&interval=daily&time_period=14&apikey=your_api_key
  ```

### **3. API 响应数据格式**

Alpha Vantage 的 API 返回的数据格式为 **JSON**。以下是一个 `TIME_SERIES_DAILY` 示例响应的简化版本：

```json
{
  "Meta Data": {
    "1. Information": "Daily Prices and Volumes",
    "2. Symbol": "MSFT",
    "3. Last Refreshed": "2025-01-02",
    "4. Time Zone": "US/Eastern"
  },
  "Time Series (Daily)": {
    "2025-01-02": {
      "1. open": "145.29",
      "2. high": "146.85",
      "3. low": "144.90",
      "4. close": "146.55",
      "5. volume": "32741000"
    },
    "2025-01-01": {
      "1. open": "144.50",
      "2. high": "146.55",
      "3. low": "143.85",
      "4. close": "145.15",
      "5. volume": "21041000"
    },
    ...
  }
}
```

#### **响应字段说明**：

- `Meta Data`：元数据，包含 API 调用的相关信息。
  - `Symbol`：股票代码。
  - `Last Refreshed`：数据更新时间。
- `Time Series (Daily)`：每个交易日的数据。
  - 每一项表示一个日期的数据，包含开盘价（`open`）、最高价（`high`）、最低价（`low`）、收盘价（`close`）和成交量（`volume`）。

### **4. 其他功能**

#### **(a) 外汇（Forex）数据**

你也可以通过类似的 API 调用获取外汇（Forex）数据。例如：

```text
https://www.alphavantage.co/query?function=FX_DAILY&from_symbol=USD&to_symbol=EUR&apikey=your_api_key
```

#### **(b) 加密货币（Crypto）数据**

获取加密货币的数据，例如比特币（BTC）对美元（USD）的每日价格：

```text
https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=BTC&to_currency=USD&apikey=your_api_key
```

### **5. 免费和付费限制**

Alpha Vantage 提供免费的 API 服务，但也有限制：

- 免费账户每分钟最多可以进行 5 次请求，每天最多 500 次请求。
- 如果需要更高频率或更多数据，可以选择 Alpha Vantage 提供的付费套餐，允许更多的请求。

### **6. 使用库与工具**

为了简化与 Alpha Vantage API 的集成，很多开发者使用现成的库。例如：

- **Python**：`alpha_vantage` Python 库
- **Dart**（Flutter）：`http` 库配合 `async` 操作
- **JavaScript**：`axios` 或 `fetch` 来发起 API 请求

---

### **总结**

- Alpha Vantage 提供股票市场、外汇、加密货币等多个数据接口。
- 通过 `TIME_SERIES`、`TECHNICAL_INDICATORS` 等功能，可以获取实时和历史数据。
- 你需要注册获取 API 密钥并通过 RESTful 接口调用这些数据。
- 免费 API 有请求频率的限制，付费账户可以解除限制并获取更多数据。

你可以根据自己的需要选择合适的 API 功能，并进行集成和分析。
