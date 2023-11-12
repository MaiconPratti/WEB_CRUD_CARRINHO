<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Loja.aspx.cs" Inherits="WEB_CRUD_CARRINHO.Loja" %>

<%@ Register TagPrefix="asp" Namespace="System.Web.UI.WebControls" Assembly="System.Web.Extensions, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31BF3856AD364E35" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="shortcut icon" href="/images/favicon.png" type="image/png" />
    <link href="~/StyleSheet.css" rel="stylesheet" />


    <title>Marketplace | Loja</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>

    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />

        <header class="header">
            <nav class="nav-container">
                <ul class="nav-list">
                    <li class="nav-item">Home</li>
                    <li class="nav-item">Produtos</li>
                    <li class="nav-item">Carrinho</li>
                </ul>
            </nav>
            <hr class="header-divider" />
            <h1 class="page-title">MARKETPLACE</h1>
            <!-- adicionar imagem de fundo css -->
        </header>


        <main>

            <section id="carrinhoSection">
                <h2>Carrinho</h2>
                <table id="carrinhoTable">
                    <tr>
                        <th>Produto</th>
                        <th>Quantidade</th>
                        <th>Preço Unitário</th>
                        <th>Total</th>
                    </tr>
                </table>
                <p id="totalCarrinho"></p>
                <button type="button" onclick="FinalizarCompra_Click()">Finalizar Compra</button>
            </section>

            <section>
                <h2>Produtos (Posters Animes)</h2>
                <div class="posters-container">
                    <div class="poster-container">
                        <strong>Dragon Ball Z</strong>
                        <br />
                        <asp:Image ID="Image1" runat="server" ImageUrl="images/DBZ.jpg" CssClass="poster-image"
                            Height="450px" Width="300px" />
                        <span class="poster-price">R$59,90</span>
                        <button type="button" runat="server" data-nome="Dragon Ball Z" data-preco="59.90"
                            onclick="AdicionarAoCarrinho_Click(this)">
                            Adicionar ao carrinho
                        </button>
                    </div>

                    <div class="poster-container">
                        <strong>Naruto</strong>
                        <br />
                        <asp:Image ID="Image2" runat="server" ImageUrl="images/naruto.jpg"
                            Height="450px" Width="300px" CssClass="poster-image" />
                        <span class="poster-price">R$59,90</span>
                        <button type="button" runat="server" data-nome="Naruto" data-preco="59.90"
                            onclick="AdicionarAoCarrinho_Click(this)">
                            Adicionar ao carrinho
                        </button>
                    </div>

                    <div class="poster-container">
                        <strong>One Piece</strong>
                        <br />
                        <asp:Image ID="Image3" runat="server" ImageUrl="images/WantedLuff.png"
                            Height="450px" Width="300px" CssClass="poster-image" />
                        <span class="poster-price">R$59,90</span>
                        <button type="button" runat="server" data-nome="One Piece" data-preco="59.90"
                            onclick="AdicionarAoCarrinho_Click(this)">
                            Adicionar ao carrinho
                        </button>
                    </div>

                    <div class="poster-container">
                        <strong>Shingeki no Kiojin</strong>
                        <br />
                        <asp:Image ID="Image4" runat="server" Height="450px"
                            ImageUrl="images/Shingeki.jpg" Width="300px" CssClass="poster-image" />
                        <span class="poster-price">R$59,90</span>
                        <button type="button" runat="server" data-nome="Shingeki no Kiojin" data-preco="59.90"
                            onclick="AdicionarAoCarrinho_Click(this)">
                            Adicionar ao carrinho
                        </button>
                    </div>
                </div>
            </section>
        </main>

        <footer>
            <div>
                <h3>Desenvolvido por: </h3>
                <p>Maicon Pratti</p>
                <p>Rickelme</p>
            </div>
        </footer>

    </form>

    <script type="text/javascript">
        function AdicionarAoCarrinho_Click(button) {
            var nomeProduto = button.getAttribute("data-nome");
            var precoProduto = parseFloat(button.getAttribute("data-preco"));

            var carrinhoTable = document.getElementById("carrinhoTable");

            // Verifica se o produto já está no carrinho
            var row = $("tr:contains('" + nomeProduto + "')", carrinhoTable);
            if (row.length > 0) {
                // Se o produto já está no carrinho, aumenta a quantidade
                var quantidadeCell = $("td:eq(1)", row);
                var quantidade = parseInt(quantidadeCell.text()) + 1;
                quantidadeCell.text(quantidade);

                // Atualiza o total
                var totalCell = $("td:eq(3)", row);
                totalCell.text("R$ " + (quantidade * precoProduto).toFixed(2));
            } else {
                // Se o produto não está no carrinho, adiciona uma nova linha
                var row = carrinhoTable.insertRow(-1);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                var cell5 = row.insertCell(4);

                cell1.innerHTML = nomeProduto;
                cell2.innerHTML = "1";
                cell3.innerHTML = "R$ " + precoProduto.toFixed(2);
                cell4.innerHTML = "R$ " + precoProduto.toFixed(2);
                cell5.innerHTML = '<button onclick="RemoverDoCarrinho_Click(this)">Remover</button>';
            }
        }

        function RemoverDoCarrinho_Click(button) {
            var row = button.parentNode.parentNode;
            row.parentNode.removeChild(row);
        }

        function AtualizarTotalCarrinho() {
            var carrinhoTable = document.getElementById("carrinhoTable");
            var total = 0;

            // Calcula o total somando o preço de cada item no carrinho
            $("tr:gt(0)", carrinhoTable).each(function () {
                var preco = parseFloat($("td:eq(3)", this).text().replace("R$ ", ""));
                total += preco;
            });

            // Exibe o total
            document.getElementById("totalCarrinho").innerText = "Total: R$ " + total.toFixed(2);

            return total;
        }

        function FinalizarCompra_Click() {
            var total = AtualizarTotalCarrinho();
            alert("Compra finalizada! Total: R$ " + total.toFixed(2));  
        }
    </script>

</body>
</html>
