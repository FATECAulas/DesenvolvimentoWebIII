// Exercícios de Node.js (JavaScript)

// 1. Manipulação de Strings: Crie uma variável com uma frase, exiba o comprimento da frase (.length) e a frase toda em maiúsculas (.toUpperCase()).
console.log("\n--- Exercício 1: Manipulação de Strings ---");
let frase = "Este é um exemplo de frase para manipulação.";
console.log("Frase original: " + frase);
console.log("Comprimento da frase: " + frase.length);
console.log("Frase em maiúsculas: " + frase.toUpperCase());

// 2. Variáveis Nulas e Indefinidas: Declare uma variável com valor null e outra sem atribuição (undefined). Exiba ambos os valores no console.
console.log("\n--- Exercício 2: Variáveis Nulas e Indefinidas ---");
let variavelNula = null;
let variavelIndefinida;
console.log("Variável nula: " + variavelNula);
console.log("Variável indefinida: " + variavelIndefinida);

// 3. Template Strings: Crie três variáveis (número, string, boolean) e utilize template strings (`text ${var}`) para combiná-las em uma única frase.
console.log("\n--- Exercício 3: Template Strings ---");
let numero = 10;
let texto = "Node.js";
let booleano = true;
let fraseCombinada = `O ${texto} é uma plataforma poderosa. O número ${numero} é um exemplo, e a afirmação é ${booleano}.`;
console.log("Frase combinada: " + fraseCombinada);

// 4. Conversão de Tipos: Crie uma variável numérica e uma string. Converta o número para string e a string para número. Exiba os novos tipos usando typeof.
console.log("\n--- Exercício 4: Conversão de Tipos ---");
let numOriginal = 123;
let strOriginal = "456";
console.log(`Original: numOriginal (${typeof numOriginal}) = ${numOriginal}, strOriginal (${typeof strOriginal}) = ${strOriginal}`);

let numParaString = String(numOriginal);
let strParaNumero = Number(strOriginal);
console.log(`Convertido: numParaString (${typeof numParaString}) = ${numParaString}, strParaNumero (${typeof strParaNumero}) = ${strParaNumero}`);

// 5. Métodos de String: Crie uma string e utilize .toLowerCase(), .slice() ou outros métodos para modificar a string original e exiba o resultado.
console.log("\n--- Exercício 5: Métodos de String ---");
let minhaString = "PROGRAMACAO EM JAVASCRIPT";
console.log("String original: " + minhaString);
console.log("Em minúsculas: " + minhaString.toLowerCase());
console.log("Slice (0, 11): " + minhaString.slice(0, 11)); // "PROGRAMACAO"
console.log("Replace (\"JAVASCRIPT\", \"NODE.JS\"): " + minhaString.replace("JAVASCRIPT", "NODE.JS"));

// 6. Tabuada com Input: Crie um programa que receba um número do usuário e exiba sua tabuada, solicitando a entrada de dados (o exercício pede para implementar entrada de usuário no terminal).
// Para simular a entrada do usuário em um ambiente de script, vamos definir um número fixo para a tabuada.
// Em um ambiente real, você usaria módulos como 'readline' ou 'prompt-sync'.
console.log("\n--- Exercício 6: Tabuada com Input (simulado) ---");
let numeroTabuada = 7; // Simula a entrada do usuário
console.log(`Tabuada do ${numeroTabuada}:`);
for (let i = 1; i <= 10; i++) {
  console.log(`${numeroTabuada} x ${i} = ${numeroTabuada * i}`);
}
