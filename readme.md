Trabalho de Laboratório de Bases de Dados
=========================================

Pre requisitos
--------------
- [Ruby][1]
- [Gem][2]
- [Bundler][3]
- [Rails][4]
- [Git][5]
- [NodeJS][6]
- [Oracle Client SDK][7]

Como rodar
----------
instale Rails e Gem e rode
```
gem install ruby-oci8
```
Caso ocorram erros, siga o passo-a-passo [passo-a-passo detalhado](https://github.com/kubo/ruby-oci8/blob/master/docs/install-instant-client.md)

clone o repositório localmente
```
git clone https://github.com/Kasama/OracleToMongoDB.git
cd OracleToMongoDB
```
atualize as gemas usadas no projeto
```
./bin/bundle install
```

rode o servidor Rails
```
rails s
```

Acesse a página no browser, por padrão [localhost:3000](http://localhost:3000)

[1]: https://www.ruby-lang.org/en/
[2]: https://rubygems.org/
[3]: https://rubygems.org/gems/bundler
[4]: https://rubygems.org/gems/rails
[5]: https://git-scm.com/
[6]: https://nodejs.org/en/
[7]: http://www.oracle.com/technetwork/database/features/instant-client/index-097480.html
