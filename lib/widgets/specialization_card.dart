import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class SpecializationCard extends StatelessWidget {
  final Specialization specialization;
  final bool isApplied;
  final VoidCallback onTap;
  final VoidCallback onContactTap;

  const SpecializationCard({
    super.key,
    required this.specialization,
    this.isApplied = false,
    required this.onTap,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = isApplied ? Colors.green : Colors.blue;
    final iconColor = isApplied ? Colors.green : Colors.blue.shade700;
    final titleColor = isApplied ? Colors.green.shade700 : Colors.black;
    final descriptionColor = isApplied ? Colors.green.shade600 : Colors.grey.shade700;
    final buttonBgColor = isApplied ? Colors.green.shade50 : Colors.blue.shade50;
    final buttonBorderColor = isApplied ? Colors.green.shade100 : Colors.blue.shade100;

    return SizedBox(
      width: 220, // Фиксированная ширина для вытянутой карточки
      height: 180, // Соответствующая высота
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(8), // Отступы между карточками
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      IconData(
                        int.parse(specialization.iconCode, radix: 16),
                        fontFamily: 'MaterialIcons',
                      ),
                      size: 32,
                      color: iconColor,
                    ),
                    const Spacer(),
                    if (isApplied)
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  specialization.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    specialization.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: descriptionColor,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 36,
                        child: ElevatedButton(
                          onPressed: onTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonBgColor,
                            foregroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: buttonBorderColor,
                              ),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: Text(
                            isApplied ? 'Отправлено' : 'Отклик',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: OutlinedButton(
                        onPressed: onContactTap,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        child: Icon(
                          Icons.phone,
                          size: 18,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}