
import fetch from 'node-fetch';

const API = 'http://localhost:3000/api';

async function main() {

  const datad = new Date("2026-05-14")
  await fetch(`${API}/empresa`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ cnpj: '66779912000111', nome: 'PAOLA LTDA', uf: 'CE', municipio: 'FORTALEZA', dataInicio: datad.toISOString() })
  });

  await fetch(`${API}/empresa`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ cnpj: '78480043000109', nome: 'TEC EXEMPLO LTDA', uf: 'CE', municipio: 'FORTALEZA', dataInicio: datad.toISOString() })
  });

  console.log('Pré-população concluída.');
}

main().catch(console.error);
