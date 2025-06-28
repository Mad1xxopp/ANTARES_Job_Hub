class Specialization {
  final String title;
  final String description;
  final String iconCode;
  final String contactPhone;

  Specialization({
    required this.title,
    required this.description,
    required this.iconCode,
    required this.contactPhone,
  });
}

class DummyData {
  static List<Specialization> specializations = [
    Specialization(
      title: 'Проектирование и реконструкция зданий и сооружений',
      description: 'Полный цикл проектных работ для промышленных и гражданских объектов',
      iconCode: 'e1b1', // Код иконки engineering
      contactPhone: '+71234567890',
    ),
    Specialization(
      title: 'Создание систем автоматизации и диспетчеризации для предприятий',
      description: 'Разработка и внедрение систем промышленной автоматизации',
      iconCode: 'e042', // Код иконки settings_input_component
      contactPhone: '+71234567890',
    ),
    Specialization(
      title: 'Установка систем видеомониторинга и аналитического видеонаблюдения',
      description: 'Монтаж и настройка интеллектуальных систем видеонаблюдения',
      iconCode: 'e04b', // Код иконки videocam
      contactPhone: '+71234567890',
    ),
    Specialization(
      title: 'Проектирование и строительство инженерных сетей',
      description: 'Комплексные решения для внутренних и внешних инженерных коммуникаций',
      iconCode: 'e1ca', // Код иконки plumbing
      contactPhone: '+71234567890',
    ),
    Specialization(
      title: 'Дистрибьюторская деятельность и поставка строительных материалов',
      description: 'Логистика и снабжение строительных объектов',
      iconCode: 'e8cc', // Код иконки local_shipping
      contactPhone: '+71234567890',
    ),
    Specialization(
      title: 'Техническая поддержка объектов связи',
      description: 'Обслуживание и модернизация телекоммуникационных систем',
      iconCode: 'e32c', // Код иконки router
      contactPhone: '+71234567890',
    ),
    Specialization(
      title: 'Монтаж инфраструктуры связи и энергетики',
      description: 'Строительство линий связи и энергоснабжения',
      iconCode: 'e1d0', // Код иконки electrical_services
      contactPhone: '+71234567890',
    ),
    Specialization(
      title: 'Строительно-монтажные работы',
      description: 'Выполнение работ на объектах специального назначения',
      iconCode: 'e869', // Код иконки construction
      contactPhone: '+71234567890',
    ),
    Specialization(
      title: 'Монтаж энергетического оборудования',
      description: 'Установка и обслуживание электротехнических систем',
      iconCode: 'e1e5', // Код иконки bolt
      contactPhone: '+71234567890',
    ),
    Specialization(
      title: 'Внедрение альтернативной энергетики (ВИЭ)',
      description: 'Проекты возобновляемых источников энергии',
      iconCode: 'e176', // Код иконки eco
      contactPhone: '+71234567890',
    ),
  ];
}