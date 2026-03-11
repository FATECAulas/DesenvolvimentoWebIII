#Exercício: 
# – Implemente um programa que contemple uma fila de contatos para umcall center; 
# – As opções do programa devem ser: 
# • Inserir Contato: 
# – Deve solicitar ao usuário os dados e incluir o contatona fila; 
# • Próximo Contato: 
# – Deverá pegar o Contato do Inicio da Fila, removê-lo emostrar os seus dados na tela para o usuário efetuar o contato com o cliente. 
# • Sair.

class Queue: #construir
    def __init__(self):
        self.items = []
    def isEmpty(self): #testar
        return self.items == []
    def enqueue(self, item): #adicionar
        self.items.insert(0,item)
    def dequeue(self): #remover
        return self.items.pop()
    
fila = Queue()
while True:
    print("\nCALL CENTER")
    print("1 - Inserir Contato")
    print("2 - Próximo Contato")
    print("3 - Sair")
    opcao = input("Escolha: ")

    if opcao == "1":
        nome = input("Nome: ")
        telefone = input ("Telefone: ")
        contato = {"nome": nome, "telefone": telefone}
        fila.enqueue(contato)
        print("Contato Adicionado")

    elif opcao == "2":
        if not fila.isEmpty():
            contato = fila.dequeue()
            print(f"Nome: {contato['nome']}, Telefone: {contato['telefone']}")
        else:
            print("Nenhum Contato encontrado")
    
    elif opcao == "3":
        break

    else:
        print("Opção inválida")
