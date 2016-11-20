// LE01ESTADO
db.runCommand({
	colmod: "LE01ESTADO",
	validator: {
		$and: [
		{ SIGLA: { $exists: true, $type: "string" } },
		{ NOME: { $exists: true, $type: "string" } }
		]
	}
});
// LE02CIDADE
db.runCommand({
	colmod: "LE02CIDADE",
	validator: {
		$and: [
		{ NOME: { $exists: true, $type: "string" } },
		{ SIGLAESTADO: { $exists: true, $type: "string" } },
		{ POPULACAO: { $exists: true, $gte: 0 } }
		]
	}
});
// LE03ZONA
db.runCommand({
	colmod: "LE03ZONA",
	validator: {
		$and: [
		{ NROZONA: { $exists: true, $gte: 0 } },
		{ NRODEURNASRESERVA: { $exists: true, $gte: 0 }}
		]
		}
	});
// LE04BAIRRO
db.runCommand({
	colmod: "LE04BAIRRO",
	validator: {
		$and: [
		{ NOME: { $exists: true, $type: "string" } },
		{ NOMECIDADE: { $exists: true, $type: "string" } },
		{ SIGLAESTADO: { $exists: true, $type: "string" } },
		{ NROZONA: { $exists: true, $gte: 0 } }
		]
	}
});
// LE05URNA
db.runCommand({
	colmod: "LE05URNA",
	validator: {
		$and: [
		{ NSERIAL: { $exists: true, $gte: 0 } },
		{ ESTADO: { $type: "string", $in: ["funcional", "manutencao"] } },
		{ NROZONA: { $gte: 0 } }
		]
	}
});
// LE06SESSAO
db.runCommand({
	colmod: "LE06SESSAO",
	validator: {
		$and: [
		{ NROSESSAO: { $exists: true, $gte: 0 } },
		{ NROZONA: { $exists: true, $gte: 0 } },
		{ NSERIAL: { $exists: true, $gte: 0 } }
		]
	}
});
// LE07PARTIDO
db.runCommand({
	colmod: "LE07PARTIDO",
	validator: {
		$and: [
		{ SIGLA: { $exists: true, $type: "string" } },
		{ NOME: { $exists: true, $type: "string" } }
		]
	}
});
// LE08CANDIDATO
db.runCommand({
	colmod: "LE08CANDIDATO",
	validator: {
		$and: [
		{ NROCAND: { $exists: true, $gte: 0 } },
		{ TIPO: { $exists: true, $in: ["politico", "especial"] } },
		{ CPF: { $gte: 0 } },
		{ NOME: { $exists: true, $type: "string" } },
		{ IDADE: { $gte: 0 } },
		{ APELIDO: { $type: "string" } },
		{ SIGLAPARTIDO: { $type: "string" } },
		{ $or: [
				{ $and: [
					{ TIPO: { $eq: "politico" }},
					{ CPF: { $exists: true }}
				]},
				{ $and: [
					{ TIPO: { $eq: "especial" }},
					{ SIGLAPARTIDO: { $exists: false }},
					{ CPF: { $exists: false }},
					{ IDADE: { $exists: false }},
					{ APELIDO: { $exists: false }}
				]}
			]
		}
		]
	}
});
// LE09CARGO
db.runCommand({
	colmod: "LE09CARGO",
	validator: {
		$and: [
		{ CODCARGO: { $exists: true, $gte: 0 } },
		{ POSSUIVICE: { $exists: true, $in: [0, 1] } },
		{ ANOBASE: { $exists: true } },
		{ ANOSMANDATO: { $exists: true, $gte: 0 } },
		{ NOMEDESCRITIVO: { $exists: true, $type: "string" } },
		{ ESFERA: { $exists: true, $in: ['E', 'F', 'M'] } },
		{ NOMECIDADE: { $exists: true, $type: "string" } },
		{ SIGLAESTADO: { $exists: true, $type: "string" } },
		{ SALARIO: { $exists: true, $gte: 0 } }
		]
	}
});
// LE10CANDIDATURA
db.runCommand({
	colmod: "LE10CANDIDATURA",
	validator: {
		$and: [
		{ REG: { $exists: true, $gte: 0 } },
		{ CODCARGO: { $exists: true, $gte: 0 } },
		{ ANO: { $exists: true, $gte: 1985, $lte: 2100 } },
		{ NROCAND: { $exists: true, $gte: 0 } },
		{ NROVICE: { $gte: 0 } }
		]
	}
});
// LE11PLEITO
db.runCommand({
	colmod: "LE11PLEITO",
	validator: {
		$and: [
		{ NROSESSAO: { $exists: true, $gte: 0 } },
		{ NROZONA: { $exists: true, $gte: 0 } },
		{ CODCARGO: { $exists: true, $gte: 0 } },
		{ ANO: { $exists: true, $gte: 1985, $lte: 2100 } },
		{ NROCAND: { $exists: true, $gte: 0 } },
		{ TOTAL: { $exists: true, $gte: 0 } }
		]
	}
});
// LE12PESQUISA
db.runCommand({
	colmod: "LE12PESQUISA",
	validator: {
		$and: [
		{ REGPESQUISA: { $exists: true, $gte: 0 } },
		{ PERIODOINICIO: { $exists: true } },
		{ PERIODOFIM: { $exists: true } },
		{ ORGAOPESQUISA: { $exists: true, $type: "string" } }
		]
	}
});
// LE13INTENCAODEVOTO
db.runCommand({
	colmod: "LE13INTENCAODEVOTO",
	validator: {
		$and: [
		{ REGPESQUISA: { $exists: true, $gte: 0 } },
		{ REGCANDID: { $exists: true, $gte: 0 } },
		{ TOTAL: { $exists: true, $gte: 0 } }
		]
	}
});
