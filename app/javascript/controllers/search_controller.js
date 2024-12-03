import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ["input", "results"]; // Lier l'input et la div des résultats
  connect() {
    fetch(`/cryptos`, {
      headers: { accept: "application/json" },
    })
      .then((response) => response.json())
      .then((data) => {
        this.resultsTarget.innerHTML = ""; // Efface les anciens résultats
        data.forEach(([id, name, symbol, price, volume_24h]) => {
          const link = document.createElement("a");
          link.href = `/cryptos/${id}`;
          link.textContent = `(${symbol}) ${name} (${price}) (${volume_24h})`;
          this.resultsTarget.appendChild(link);
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
        this.resultsTarget.innerHTML = ""; // Efface les anciens résultats
        data.forEach(([id, name, symbol, price, volume_24h]) => {
          const link = document.createElement("a");
          link.href = `/cryptos/${id}`;
          link.textContent = `(${symbol}) ${name} (${price}) (${volume_24h})`;
          this.resultsTarget.appendChild(link);
        });
      });
  }
  
}