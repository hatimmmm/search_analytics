import { Controller } from "@hotwired/stimulus";
import debounce from "debounce";

export default class extends Controller {
  static targets = ["input", "results"];
  static values = { url: String };

  connect() {
    this.perform = debounce(this.perform, 300).bind(this);
  }

  perform(event) {
    const query = this.inputTarget.value.trim();

    if (query.length <= 1) {
      this.resultsTarget.innerHTML = "";
      return;
    }

    console.log("Performing search for:", query);

    fetch(this.urlValue, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
      },
      body: JSON.stringify({ query: query }),
    })
      .then((response) => response.json())
      .then((articles) => {
        this.renderResults(articles);
      })
      .catch((error) => {
        console.error("Error fetching search results:", error);
        this.resultsTarget.innerHTML =
          "<p class='p-4 text-red-500'>Error loading results.</p>";
      });
  }

  renderResults(articles) {
    this.resultsTarget.innerHTML = "";

    if (articles.length === 0) {
      this.resultsTarget.innerHTML =
        "<p class='p-4 text-gray-500'>No articles found.</p>";
      return;
    }

    const list = document.createElement("ul");
    list.className = "divide-y divide-gray-200";

    articles.forEach((article) => {
      const item = document.createElement("li");
      item.className = "p-4 hover:bg-gray-50 cursor-pointer";
      item.innerHTML = `
        <h3 class="font-semibold text-gray-800">${article.title}</h3>
        <p class="text-sm text-gray-600">${article.content.substring(
          0,
          100
        )}...</p>
      `;
      list.appendChild(item);
    });

    this.resultsTarget.appendChild(list);
  }
}
