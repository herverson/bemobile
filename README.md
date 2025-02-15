# bemobile
![video](https://github.com/user-attachments/assets/e4010e3c-8f82-4553-b549-0870cae78c0b)

Desafio técnico

<p>
  Este é um aplicativo Flutter que exibe uma lista de funcionários, utilizando a arquitetura Clean Architecture, gerenciamento de estado com Bloc/Cubit, injeção de dependência com GetIt e com testes no projeto.
</p>
    <h2> Funcionalidades </h2>
    <ul>
      <li><strong>Splash Screen:</strong> Exibe uma tela de abertura com o logo do aplicativo.</li>
      <li><strong>Lista de Funcionários:</strong> Exibe uma lista de funcionários com nome, cargo, telefone e data de admissão.</li>
      <li><strong>Filtro de Pesquisa:</strong> Permite filtrar funcionários por nome, cargo ou telefone.</li>
      <li><strong>Gerenciamento de Estado:</strong> Utiliza Bloc/Cubit para gerenciar o estado da aplicação.</li>
      <li><strong>Injeção de Dependência:</strong> Utiliza GetIt para gerenciar as dependências do projeto.</li>
      <li><strong>Testes:</strong> Testes de lógicas e widgets.</li>
    </ul>
    <h2>Estrutura do Projeto</h2>
    <p>O projeto segue a estrutura de pastas da Clean Architecture:</p>
    <pre>
lib/
  |- data/
     |- datasources/         # Fontes de dados (ex: API, banco de dados)
     |- repositories/        # Implementações dos repositórios
  |- domain/
     |- entities/            # Entidades do domínio
     |- repositories/        # Interfaces dos repositórios
  |- presentation/
     |- cubit/               # Gerenciamento de estado com Cubit
     |- pages/               # Telas do aplicativo
     |- splash/              # Tela de Splash e lógica relacionada
  |- service_locator.dart    # Configuração do GetIt
    </pre>
    <h2>Configuração do Ambiente</h2>
    <h3>Pré-requisitos</h3>
    <ul>
      <li>Flutter SDK instalado (versão 3.0 ou superior).</li>
      <li>Dart SDK instalado (versão 2.17 ou superior).</li>
    </ul>
    <h3>Passos para Executar o Projeto</h3>
    <ol>
      <li><strong>Clone o repositório:</strong>
        <pre><code>git clone https://github.com/herverson/bemobile.git
cd bemobile</code></pre>
      </li>
      <li><strong>Instale as dependências:</strong>
        <pre><code>flutter pub get</code></pre>
      </li>
      <li><strong>Execute o aplicativo:</strong>
        <pre><code>flutter run</code></pre>
      </li>
      <li><strong>Execute os testes:</strong>
        <pre><code>flutter test</code></pre>
      </li>
    </ol>
