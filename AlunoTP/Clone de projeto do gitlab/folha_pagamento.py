class Funcionario:
    def __init__(self, nome, salario_base, dependentes=0):
        self.nome = nome
        self.salario_base = salario_base
        self.dependentes = dependentes

    def calcular_ferias(self):
        return self.salario_base + (self.salario_base / 3)

    def calcular_salario_familia(self):
        salario_familia_por_dependente = 50
        return self.dependentes * salario_familia_por_dependente

    def calcular_juros_sobre_salario(self, taxa_juros, meses):
        juros = self.salario_base * (taxa_juros / 100) * (meses / 12)
        return juros

    def calcular_folha_pagamento(self, taxa_juros, meses):
        salario_com_juros = self.salario_base + self.calcular_juros_sobre_salario(taxa_juros, meses)
        ferias = self.calcular_ferias()
        salario_familia = self.calcular_salario_familia()
        
        total = salario_com_juros + ferias + salario_familia
        return total
