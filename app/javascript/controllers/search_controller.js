import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "results"];
  connect() {
    fetch(`/cryptos`, {
      headers: { accept: "application/json" },
    })
      .then((response) => response.json())
      .then((data) => {
        this.resultsTarget.innerHTML = "";
        data.forEach(([id, name, symbol, price, volume_24h]) => {
          const div = document.createElement("div");
          const link = document.createElement("a");
          link.href = `/cryptos/${id}`;
          link.textContent = `${symbol} ${name} (${price}) (${volume_24h})`;
          div.appendChild(link);
          this.resultsTarget.appendChild(div);
        });
      });
  }



  search() {
    const query = this.inputTarget.value.trim();
  
    fetch(`/cryptos?search=${query}`, {
      headers: { accept: "application/json" },
    })
      .then((response) => response.json())
      .then((data) => {
        this.resultsTarget.innerHTML = "";
        data.forEach(([id, name, symbol, price, volume_24h]) => {
          const div = document.createElement("div");
          const link = document.createElement("a");
          link.href = `/cryptos/${id}`;
          link.textContent = `${symbol} ${name} (${price}) (${volume_24h})`;
          div.appendChild(link);
          this.resultsTarget.appendChild(div);
        });
      });
  }
}