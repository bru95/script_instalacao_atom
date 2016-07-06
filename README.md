Passo a passo para a instalação do ICA-AtoM no Ubuntu LTS 14.04:

1. Faça o download do arquivo “Instalação-AtoM.tar.gz”.
2. Extraia os arquivos em algum diretório do seu computador. Para extrair, basta clicar com o botão direito sobre o arquivo, e clicar em “Extrair aqui”.
3. É muito importante que o arquivo script.sh e os arquivos atom e atom.conf estejam na mesma pasta.
4. Abra o terminal, e navegue até a pasta onde você extraiu os arquivos.
1. Para navegar até um diretório pelo terminal, você deve utilizar o comando “cd <nome da pasta>”. O comando “ls” pode auxiliá-lo a verificar quais arquivos e pastas existem no diretório atual. (para ver mais consulte: http://www.computerhope.com/unix/ucd.htm , http://www.guiafoca.org/cgs/guia/iniciante/ch-bas.html#s-basico-comandos)
5. Ainda no terminal, entre com o comando “sudo su” e em seguinda, insira a senha do seu usuário. Isso permitirá que você realize tarefas administrativas, como instalar programas, com permissões de super usuário (root).
6. Estando no diretório correto, execute o script para instalar o software ICA-AtoM e todas as suas depêndencias. Basta digitar no terminal: ./script.sh
7. Aguarde até que a instalação do ICA-AtoM seja concluída e insira informações sempre que solicitado.
8. Ao final da instalação, você será notificado pelo terminal e deverá concluir a instalação e configuração do ICA-AtoM através do navegador. Acesse “http://localhost” através do seu navegador favorito e, se tudo estiver OK, será apresentado ao web installer do ICA-AtoM. Basta inserir os dados necessários e seguir os passos na interface.

	Como comentado no passo 7, algumas informações são necessárias durante a execução do script de instalação. Caso programas como o MySQL não estejam instalados, será necessário definir uma senha para o usuário root do servidor de banco de dados. Você saberá que chegou nesta etapa quando a tela do terminal ficar com um tema azulado.
	A senha para o MySQL será necessária para a criação das tabelas do ICA-AtoM, e é solicitada próximo do final da instalação e também durante a configuração através do navegador.