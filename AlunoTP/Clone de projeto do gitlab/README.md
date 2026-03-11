# Sistema de Folha de Pagamento

Este projeto implementa um sistema simples de folha de pagamento para calcular férias, salário-família, juros sobre o salário e o valor total da folha de pagamento para funcionários. Inclui testes unitários para garantir o correto funcionamento dos métodos principais.

## 📁 Estrutura do Projeto

O projeto possui as seguintes classes principais:

- **Funcionario**: Classe que representa o funcionário e contém métodos para realizar cálculos da folha de pagamento.
- **TestFuncionario**: Classe de testes unitários, desenvolvida com a biblioteca `unittest`, para verificar a funcionalidade dos métodos da classe `Funcionario`.

## 📚 Classe Funcionario

A classe `Funcionario` oferece os métodos principais descritos abaixo:

- `__init__(self, nome, salario_base, dependentes=0)`: Inicializa o funcionário com nome, salário base e número de dependentes (opcional, padrão 0).
  
- `calcular_ferias(self)`: Calcula o valor das férias, que corresponde ao salário base acrescido de um terço.

- `calcular_salario_familia(self)`: Calcula o salário-família, considerando um valor fixo de R$ 50,00 por dependente.

- `calcular_juros_sobre_salario(self, taxa_juros, meses)`: Calcula o valor dos juros sobre o salário, considerando uma taxa de juros anual e o número de meses.

- `calcular_folha_pagamento(self, taxa_juros, meses)`: Calcula o valor total da folha de pagamento, incluindo salário com juros, férias e salário-família.

## 🧪 Testes Unitários

Os testes unitários são implementados na classe `TestFuncionario`, localizada no arquivo `test_folha_pagamento.py`. Estes testes garantem a precisão dos métodos da classe `Funcionario`. Os testes incluem:

- `teste_calcular_ferias`: Verifica se o cálculo das férias está correto.
- `test_calcular_salario_familia`: Verifica se o cálculo do salário-família está correto.
- `test_calcular_juros_sobre_salario`: Verifica se o cálculo de juros sobre o salário está correto.
- `test_calcular_folha_pagamento`: Verifica se o cálculo total da folha de pagamento está correto.

## 🚀 Como Executar o Projeto

1. Clone o repositório:

   ```bash
   git clone https://github.com/seu_usuario/folha_pagamento.git

2. Instale os requisitos (se necessário):

   ```bash
   pip install -r requirements.txt

3. Execute os testes:
   ```bash
   python -m unittest test_folha_pagamento.py

4. Os resultados dos testes aparecerão no terminal, mostrando se todos os cálculos estão corretos.

## 🤝 Contribuindo
Contribuições são sempre bem-vindas! Sinta-se à vontade para sugerir melhorias, corrigir erros, ou adicionar novas funcionalidades.

Nota: Este é um projeto educacional e de demonstração, ideal para quem deseja aprender sobre sistemas de cálculo de folha de pagamento e testes unitários em Python.


