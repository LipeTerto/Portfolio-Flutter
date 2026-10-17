import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const PortfolioApp());

const Color bg = Color(0xFF0B1020);
const Color panel = Color(0xFF121A2D);
const Color accent = Color(0xFF7C5CFC);
const Color cyan = Color(0xFF48D6D2);
const Color muted = Color(0xFF9AA7C2);

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filipe Teixeira Terto | Portfólio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Arial',
        useMaterial3: true,
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  // Personalize estes links antes de publicar.
  static const githubUrl = 'https://github.com/LipeTerto';
  static const linkedinUrl = 'https://www.linkedin.com/in/filipe-teixeira-terto-a04656261';
  static const emailAddress = 'filipeterto26@gmail.com';

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _sendEmail() async {
    final uri = Uri(scheme: 'mailto', path: emailAddress,
        queryParameters: {'subject': 'Contato pelo portfólio'});
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _scrollTo(BuildContext context, String section) {
    final key = section == 'projetos'
        ? projectsKey
        : section == 'sobre'
            ? aboutKey
            : contactKey;
    final targetContext = key.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  static final projectsKey = GlobalKey();
  static final aboutKey = GlobalKey();
  static final contactKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SelectionArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: bg.withValues(alpha: 0.96),
              surfaceTintColor: Colors.transparent,
              title: const Text('FT.',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: cyan,
                      letterSpacing: 1.5)),
              actions: [
                _navButton(context, 'Projetos', 'projetos'),
                _navButton(context, 'Sobre', 'sobre'),
                _navButton(context, 'Contato', 'contato'),
                const SizedBox(width: 18),
              ],
            ),
            SliverToBoxAdapter(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 46),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _hero(context),
                        const SizedBox(height: 72),
                        _sectionHeading('Projetos em destaque',
                            'Alguns projetos e experiências da minha jornada.'),
                        const SizedBox(height: 22),
                        Container(
                          key: projectsKey,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final columns = constraints.maxWidth > 760 ? 2 : 1;
                              return GridView.count(
                                crossAxisCount: columns,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                mainAxisSpacing: 18,
                                crossAxisSpacing: 18,
                                childAspectRatio: columns == 2 ? 1.28 : 1.5,
                                children: [
                                  _projectCard(
                                    icon: Icons.music_note,
                                    tag: 'JavaScript • HTML • CSS • React • Vite',
                                    title: 'Projeto Spotify',
                                    description:
                                        'Réplica do Spotify, desenvolvida com fins exclusivamente educacionais, como parte do aprendizado prático durante o curso Jornada Full Stack da Hashtag Treinamentos.',
                                    features: const [
                                      'Estruturação de um projeto Full Stack',
                                      'Consumo de dados a partir de um banco de dados - MongoDB',
                                      'Criação de componentes reutilizáveis com React',
                                      'Organização de código e boas práticas',
                                      'Integração entre Front-end e Back-end'
                                    ],
                                    url: 'https://github.com/LipeTerto/Projeto-Spotify',
                                  ),
                                  _projectCard(
                                    icon: Icons.smart_toy_outlined,
                                    tag: 'Python • Streamlit • Flask • LLM • JSON',
                                    title: 'SARA - Assistente de Gestão e Desempenho',
                                    description:
                                        'Projeto de Assistente Virtual com IA capaz de automatizar processos operacionais como criação, validação e cancelamento de Folhas de Registro (FR), simulando integração com SAP ECC.',
                                    features: const [
                                      'Leitura de arquivos (PDF/DOCX)',
                                      'Validação de dados (Contrato, Centro de Custo, Aprovador)',
                                      'Criação de Folhas de Registro',
                                      'Cancelamento via chat e dashboard',
                                      'Dashboard interativo (Streamlit)',
                                      'Consultas inteligentes via linguagem natural'
                                    ],
                                    url: 'https://github.com/LipeTerto/Agente-SARA--IA-para-automacao-de-processos-de-GD',
                                  ),
                                  _projectCard(
                                    icon: Icons.memory,
                                    tag: 'Arduino Uno R3 • Sensor de temperatura TMP36 • Sensor de movimento PIR • C++',
                                    title: 'PetCare Monitor – Sistema Inteligente de Bem-Estar Animal',
                                    description:
                                        'O projeto consiste em um sistema embarcado utilizando Arduino, desenvolvido para monitorar o bem-estar de animais domésticos, especialmente cães, através da análise de dois fatores principais: temperatura corporal e movimentação.',
                                    features: const [
                                      'Arduino Uno R3',
                                      'Sensor de temperatura TMP36',
                                      'Sensor de movimento PIR',
                                      'LED RGB',
                                      'Resistores (220Ω)',
                                      'Buzzer (Piezo)',
                                      'Protoboard',
                                      'Jumpers (fios de conexão)'
                                    ],
                                    url: 'https://github.com/LipeTerto/PetCare-Monitor-Sistema-Inteligente-de-Bem-Estar-Animal',
                                  ),
                                  _projectCard(
                                    icon: Icons.currency_exchange,
                                    tag: '.NET • C# • Docker • RPA',
                                    title: 'Rastreador de Moeda',
                                    description:
                                        'Sistema automatizado de captura e disponibilização de cotações de moedas em tempo real, composto por um RPA Worker e uma Web API RESTful, ambos containerizados com Docker.',
                                    features: const [
                                      'SQLite com volume compartilhado',
                                      'Polly para resiliência',
                                      'Separação de responsabilidades',
                                      'Entity Framework Core com EnsureCreated'
                                    ],
                                    url: 'https://github.com/LipeTerto/Rastreador-de-Moeda',
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 72),
                        Container(
                          key: aboutKey,
                          child: _aboutSection(context),
                        ),
                        const SizedBox(height: 72),
                        Container(
                          key: contactKey,
                          child: _contactSection(context),
                        ),
                        const SizedBox(height: 40),
                        const Divider(color: Color(0xFF263149)),
                        const SizedBox(height: 18),
                        const Center(
                          child: Text(
                            'Desenvolvido com Flutter • Portfólio pessoal',
                            style: TextStyle(color: muted, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navButton(BuildContext context, String label, String section) {
    return TextButton(
      onPressed: () => _scrollTo(context, section),
      child: Text(label, style: const TextStyle(color: Colors.white70)),
    );
  }

  Widget _hero(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final compact = constraints.maxWidth < 700;
      final intro = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: accent.withValues(alpha: 0.4)),
                  ),
                  child: const Text('DESENVOLVIMENTO DE SOFTWARE',
                      style: TextStyle(
                          color: cyan,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2)),
                ),
                const SizedBox(height: 22),
                Text(
                  'Olá, eu sou\nFilipe!',
                  style: TextStyle(
                    fontSize: compact ? 42 : 58,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.8,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Estudante de Desenvolvimento de Software Multiplataforma e profissional de TI, interessado em desenvolvimento, automação e qualidade de software.',
                  style: TextStyle(
                      color: muted, fontSize: 17, height: 1.7),
                ),
                const SizedBox(height: 26),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    FilledButton.icon(
                      onPressed: () => _scrollTo(context, 'projetos'),
                      icon: const Icon(Icons.code),
                      label: const Text('Ver projetos'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _openUrl(githubUrl),
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('GitHub'),
                    ),
                  ],
                ),
              ],
            );
      final highlight = Container(
              width: compact ? double.infinity : null,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1C2850), Color(0xFF151C32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: const Color(0xFF344269)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.terminal, color: cyan, size: 36),
                  const SizedBox(height: 18),
                  const Text('Construindo soluções com tecnologia',
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  const Text(
                    'Aprendendo, desenvolvendo projetos e transformando ideias em aplicações.',
                    style: TextStyle(color: muted, height: 1.6),
                  ),
                  const SizedBox(height: 22),
                  const Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      SkillChip('C# / .NET'),
                      SkillChip('SQL'),
                      SkillChip('Python'),
                      SkillChip('Dart / Flutter'),
                      SkillChip('Git'),
                    ],
                  ),
                ],
              ),
            );
      if (compact) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [intro, const SizedBox(height: 32), highlight],
        );
      }
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: intro),
          const SizedBox(width: 55),
          Expanded(flex: 2, child: highlight),
        ],
      );
    });
  }

  Widget _sectionHeading(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text(subtitle,
            style: const TextStyle(color: muted, fontSize: 15, height: 1.5)),
      ],
    );
  }

  Widget _projectCard({
    required IconData icon,
    required String tag,
    required String title,
    required String description,
    required List<String> features,
    required String url,
  }) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF263149)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(13)),
                child: Icon(icon, color: cyan, size: 24),
              ),
              const Spacer(),
              IconButton(
                tooltip: 'Abrir repositório',
                onPressed: () => _openUrl(url),
                icon: const Icon(Icons.arrow_outward, color: cyan),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(tag,
              style: const TextStyle(
                  color: cyan, fontSize: 11, fontWeight: FontWeight.w700)),
          const SizedBox(height: 7),
          Text(title,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Expanded(
            child: Text(description,
                style: const TextStyle(color: muted, height: 1.45)),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: features.map((f) => SkillChip(f)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _aboutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF263149)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeading('Sobre mim', 'Tecnologia, aprendizado e evolução contínua.'),
          const SizedBox(height: 18),
          const Text(
            'Sou estudante de Desenvolvimento de Software Multiplataforma na Fatec Osasco e atuo na área de TI com foco em Segurança da Informação e Qualidade de Acessos. Tenho interesse em desenvolvimento de software, banco de dados, automação e qualidade de software, buscando ampliar meus conhecimentos por meio de projetos práticos.',
            style: TextStyle(color: muted, height: 1.8, fontSize: 15),
          ),
          const SizedBox(height: 22),
          const Text('Tecnologias e conhecimentos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 9,
            runSpacing: 9,
            children: [
              SkillChip('C#'),
              SkillChip('.NET'),
              SkillChip('Unity'),
              SkillChip('Dart'),
              SkillChip('Flutter'),
              SkillChip('Python'),
              SkillChip('SQL Server'),
              SkillChip('MySQL'),
              SkillChip('Git / GitHub'),
              SkillChip('Java'),
              SkillChip('HTML / CSS / Javascript'),
              SkillChip('QA / Testes'),
              SkillChip('SAP / GRC'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contactSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFF24204B), Color(0xFF14283B)]),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF3C4774)),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        final compact = constraints.maxWidth < 650;
        final intro = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Vamos nos conectar?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
            SizedBox(height: 10),
            Text(
              'Estou aberto a oportunidades, colaborações e novos desafios em tecnologia.',
              style: TextStyle(color: muted, height: 1.6),
            ),
          ],
        );
        final actions = Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            FilledButton.icon(
              onPressed: _sendEmail,
              icon: const Icon(Icons.mail_outline),
              label: const Text('E-mail'),
            ),
            OutlinedButton.icon(
              onPressed: () => _openUrl(linkedinUrl),
              icon: const Icon(Icons.person_outline),
              label: const Text('LinkedIn'),
            ),
          ],
        );
        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [intro, const SizedBox(height: 22), actions],
          );
        }
        return Row(
          children: [
            Expanded(flex: 3, child: intro),
            const SizedBox(width: 24),
            Expanded(flex: 2, child: actions),
          ],
        );
      }),
    );
  }
}

class SkillChip extends StatelessWidget {
  final String label;
  const SkillChip(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF202B43),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: const Color(0xFF354361)),
      ),
      child: Text(label,
          style: const TextStyle(color: Color(0xFFD9E3FA), fontSize: 11)),
    );
  }
}
