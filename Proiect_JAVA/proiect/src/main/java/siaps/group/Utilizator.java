package siaps.group;

import javax.persistence.*;
import lombok.*;

@NoArgsConstructor
@RequiredArgsConstructor
@Getter @Setter @ToString
@Entity
@Table(name = "utilizatori")
public class Utilizator {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_utilizator;

    @NonNull private String nume;

    @Column(unique = true)
    @NonNull private String utilizator;

    @NonNull private String parola;

    @NonNull private String rol;
}
